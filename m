From: r-woodruff2@ti.com (Woodruff, Richard)
Date: Wed, 22 Jul 2015 20:13:08 +0000
Subject: [PATCH 3/4] Revert "ARM: OMAP4: remove dead kconfig option
 OMAP4_ERRATA_I688"
In-Reply-To: <E1ZFQmH-0006GH-22@rmk-PC.arm.linux.org.uk>
References: <20150715174647.GA7557@n2100.arm.linux.org.uk>
 <E1ZFQmH-0006GH-22@rmk-PC.arm.linux.org.uk>
Message-ID: <EF62F09C0797D947AD4180A1043C0DF740BB3AD2@DLEE11.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> From: linux-arm-kernel [mailto:linux-arm-kernel-
> bounces at lists.infradead.org] On Behalf Of Russell King
> Sent: Wednesday, July 15, 2015 12:47 PM

> This reverts commit 606da4826b89b044b51e3a84958b802204cfe4c7.
> 
> We actually need this code for proper behaviour of OMAP4, and it needs
> fixing a different way other than just removing the code.  Disabling code
> which is necessary in the hopes of persuing multiplatform kernels is a stupid
> approach.
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

The series looks good.  It improves code generation and fixes race issues which have been see production devices running Linux.

Acked-by: Richard Woodruff <r-woodruff2@ti.com>
