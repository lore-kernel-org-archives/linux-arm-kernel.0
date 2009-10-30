From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 30 Oct 2009 12:39:16 +0000
Subject: [PATCH][RE-SUBMIT] Default setting of the ARM_UNWIND option
In-Reply-To: <4AEAC9D8.9000304@evidence.eu.com>
References: <4AD73DA4.4050006@evidence.eu.com>
	<1255620333.10164.77.camel@pc1117.cambridge.arm.com>
	<4AE55D83.7080608@evidence.eu.com>
	<1256555452.5282.21.camel@pc1117.cambridge.arm.com>
	<4AE82D17.6040900@evidence.eu.com>
	<1256741902.27121.29.camel@pc1117.cambridge.arm.com>
	<4AEAC9D8.9000304@evidence.eu.com>
Message-ID: <1256906356.27014.22.camel@pc1117.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2009-10-30 at 12:11 +0100, Claudio Scordino wrote:
> From: Claudio Scordino <claudio@evidence.eu.com>
> Date: Fri, 30 Oct 2009 11:46:00 +0100
> Subject: [PATCH 1/1] ARM unwind is known to compile only with EABI and
> not-buggy compilers.
> 
> ARM unwind is known to compile only with EABI and not-buggy compilers.
> The problem is not the unwinding information but the
> -fno-frame-pointer option added as a result of !CONFIG_FRAME_POINTER.
> Now we check the compiler and raise a #warning in case of wrong
> compiler.
> 
> 
> Signed-off-by: Claudio Scordino <claudio@evidence.eu.com>

Unless others have objections, here's my ack:

Acked-by: Catalin Marinas <catalin.marinas@arm.com>

-- 
Catalin
