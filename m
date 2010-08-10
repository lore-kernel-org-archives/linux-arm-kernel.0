From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 10 Aug 2010 18:07:52 +0100
Subject: [PATCH 05/10] ARM: ftrace: add ENDPROC annotations
In-Reply-To: <20100421192319.GA16719@debian>
References: <20100421192319.GA16719@debian>
Message-ID: <1281460072.16880.47.camel@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rabin,

On Wed, 2010-04-21 at 20:23 +0100, Rabin Vincent wrote:
> From 87b70ed633da00fe9873a5819c6d24e57368de43 Mon Sep 17 00:00:00 2001
> From: Rabin Vincent <rabin@rab.in>
> Date: Sun, 14 Feb 2010 01:18:33 +0530
> Subject: [PATCH] ARM: ftrace: add ENDPROC annotations
> 
> When building as Thumb-2, the ".type foo, %function" annotation in
> ENDPROC seems to be required in order for the assembly routines to be
> recognized as Thumb-2 code.  If the ENDPROC annotations are not present,
> calls to these routines are generated as BLX instead of BL.
> 
> Acked-by: Catalin Marinas <catalin.marinas@arm.com>
> Signed-off-by: Rabin Vincent <rabin@rab.in>

What's the status of these patches? I haven't seen them in mainline.

Thanks.

-- 
Catalin
