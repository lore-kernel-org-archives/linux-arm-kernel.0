From: leoli@freescale.com (Li Yang)
Date: Fri, 25 Sep 2015 11:37:16 -0500
Subject: [PATCH 2/2] irqchip/Layerscape: Add Layerscape MSI controller
 support
In-Reply-To: <1442482127-32674-2-git-send-email-Minghuan.Lian@freescale.com>
References: <1442482127-32674-1-git-send-email-Minghuan.Lian@freescale.com>
 <1442482127-32674-2-git-send-email-Minghuan.Lian@freescale.com>
Message-ID: <CADRPPNRx2QwZya83hYhOPKPhZj5moYr0VFR=+0VoK3PjmVVFjA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 17, 2015 at 4:28 AM, Minghuan Lian
<Minghuan.Lian@freescale.com> wrote:
> Some SoC of Freescale Layerscape provide a kind of MSI controller
> which uses two registers MSIIR and MSIR to support 32 MSI
> interrupts for each PCIe controller. The patch is to support it.

If this only applies to LS1 please say explicitly that this is only
for Layerscape 1 series in the title, commit message and code comment.
It seems that we are not delivering a consistent message here.
Although I don't even know if associating this with LS 1 series will
stay true in the future.  Maybe we should instead mention it as MSI
controller with an old GIC?


Regards,
Leo
