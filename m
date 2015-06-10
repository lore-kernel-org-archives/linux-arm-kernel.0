From: dinguyen@opensource.altera.com (Dinh Nguyen)
Date: Wed, 10 Jun 2015 17:46:36 -0500
Subject: [PATCH v2] ARM: socfpga: add smp_ops.cpu_kill to make kexec/kdump
 available
In-Reply-To: <20150610074719.22583.63623.stgit@arietta>
References: <20150610074719.22583.63623.stgit@arietta>
Message-ID: <5578BE4C.3050805@opensource.altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/10/2015 02:47 AM, Hiraku Toyooka wrote:
> Kexec_load syscall in ARM requires that machine-specific code
> has the smp_ops.cpu_kill() before loading kernel image.
> This patch adds the cpu_kill(), as a result, kexec reboot and
> kernel crash dump become available in mach-socfpga.
> 
> Signed-off-by: Hiraku Toyooka <hiraku.toyooka.gu@hitachi.com>
> Cc: Dinh Nguyen <dinguyen@opensource.altera.com>
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: linux-kernel at vger.kernel.org
> ---
>  arch/arm/mach-socfpga/platsmp.c |   12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 

Applied!

Thanks,
Dinh
