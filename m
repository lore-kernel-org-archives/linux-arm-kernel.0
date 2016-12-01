From: ramana.gcc@googlemail.com (Ramana Radhakrishnan)
Date: Thu, 1 Dec 2016 10:00:59 +0000
Subject: No subject
Message-ID: <CAJA7tRbYgrD-Y7Em6Fcybv3xxCUnJjP8vgjMYhn+81Ns9YbsjA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>
> By the way, how is this implemented?  Some of them overlap existing
> callee-saved registers.


The AArch64 PCS requires that only the bottom 64 bits of SIMD
registers (v8-v15) are callee-saved. The top 64 bits of the current
Advanced SIMD registers are the responsibility of the caller. This
naturally extends to SVE.


Ramana
