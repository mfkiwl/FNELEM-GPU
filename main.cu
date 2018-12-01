/**
FNELEM-GPU MAIN FILE
Performs finite element structural analysis using an 4-node membrane, matrix inversion
was calculated using a CUDA algorithm (Gauss Jordan inversion).

@author ppizarror
@date 19/11/2018
@license
	MIT License
	Copyright (c) 2018 Pablo Pizarro R.

	Permission is hereby granted, free of charge, to any person obtaining a copy
	of this software and associated documentation files (the "Software"), to deal
	in the Software without restriction, including without limitation the rights
	to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
	copies of the Software, and to permit persons to whom the Software is
	furnished to do so, subject to the following conditions:

	The above copyright notice and this permission notice shall be included in all
	copies or substantial portions of the Software.

	THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
	IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
	FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
	AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
	LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
	OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
	SOFTWARE.
*/

// CUDA library imports
#include "cuda_runtime.h"
#include "device_launch_parameters.h"
#include <stdio.h>
#include <vector>

// FNELEM library imports
#include "fnelem/math/fematrix.cpp"
#include "fnelem/math/fematrix_utils.cpp"
#include "fnelem/math/matrix_inversion_cpu.cpp"
#include "fnelem/math/matrix_inversion_cuda.cu"

#include "fnelem/model/base/model_component.cpp"
#include "fnelem/model/elements/element.cpp"
#include "fnelem/model/elements/membrane.cpp"
#include "fnelem/model/loads/load.cpp"
#include "fnelem/model/loads/load_membrane_distributed.cpp"
#include "fnelem/model/loads/load_node.cpp"
#include "fnelem/model/nodes/node.cpp"
#include "fnelem/model/restraints/restraint.cpp"
#include "fnelem/model/restraints/restraint_node.cpp"

#include "test/test_suite.h"

int main() {

    // Test all
    test_suite();

    // Creates matrix
    FEMatrix mat = FEMatrix(3, 3);
    mat.set(0, 0, 1);
    mat.set(0, 1, 2);
    mat.set(0, 2, 3);
    mat.set(1, 0, 5);
    mat.set(1, 1, 2);
    mat.set(1, 2, 1);
    mat.set(2, 0, 2);
    mat.set(2, 1, 2);
    mat.set(2, 2, 3);

    FEMatrix *imat = matrix_inverse_cuda(&mat);
    imat->disp();
    delete imat;

    return 0;
}