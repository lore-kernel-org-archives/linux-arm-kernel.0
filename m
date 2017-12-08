From: gregkh@linuxfoundation.org (Greg KH)
Date: Fri, 8 Dec 2017 07:31:32 +0100
Subject: [PATCH 1/2] ARM: BUG if jumping to usermode address in kernel mode
In-Reply-To: <e795ff2c-4419-c585-6064-f761efc16448@linaro.org>
References: <20171125113302.GY31757@n2100.armlinux.org.uk>
 <E1eIYiX-0007t0-AH@rmk-PC.armlinux.org.uk>
 <e795ff2c-4419-c585-6064-f761efc16448@linaro.org>
Message-ID: <20171208063132.GB6194@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 08, 2017 at 09:02:04AM +0800, Alex Shi wrote:
> CC GregKH, since this patch would better to get to stable kernel.
> This patch also expose a qemu issue which fixed by upstream commit:
> 3aaf33bebda8d4ffcc0f ARM: avoid faulting on qemu
> 
> Both of patches are tested in linaro's kernelci and LKFT on stable
> kernel 4.4/4.9/4.14, no regressions. The lts 3.18 isn't applicable for
> this patches.

<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>
