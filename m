From: jerome.forissier@linaro.org (=?UTF-8?B?SsOpcsO0bWUgRm9yaXNzaWVy?=)
Date: Wed, 24 Jun 2015 10:29:42 +0200
Subject: [PATCH] XOR implementation for ARMv8
In-Reply-To: <463b2fe9.7d02.14e245e3541.Coremail.liuxiaodong@nudt.edu.cn>
References: <463b2fe9.7d02.14e245e3541.Coremail.liuxiaodong@nudt.edu.cn>
Message-ID: <558A6A76.6060705@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 06/24/2015 09:00 AM, ??? wrote:
> Use the 128-bit SIMD registers and SIMD arithmetic instructions for XOR calculation in assembly language. 

Don't you need kernel_neon_begin()/kernel_neon_end() somewhere? (see
Documentation/arm/kernel_mode_neon.txt).

-- 
Jerome
