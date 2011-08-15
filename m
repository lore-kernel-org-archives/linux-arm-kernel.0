From: PeterHuewe@gmx.de (Peter =?iso-8859-2?q?H=FCwe?=)
Date: Mon, 15 Aug 2011 16:30:11 +0200
Subject: [PATCH] shmobile/sh7372: Add missing CONFIG_PM guards to fix
	build failure
In-Reply-To: <201108140155.05625.rjw@sisk.pl>
References: <1313274841-8322-1-git-send-email-peterhuewe@gmx.de>
	<201108140155.05625.rjw@sisk.pl>
Message-ID: <201108151630.12120.PeterHuewe@gmx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Sonntag 14 August 2011, 01:55:05 schrieb Rafael J. Wysocki:
> On Sunday, August 14, 2011, Peter Huewe wrote:
> > This patch fixes a build failure with the ap4evb_defconfig by adding the
> > missing #ifdef CONFIG_PM.
> 
> This is not the right fix.  Besides, you seem to be testing linux-next
> and the build problem is in the linux-pm tree.
> 
> Please check if the appended patch fixes the problem for you.
> 
> Rafael
Works for me - compiles ;)

Reviewed-by: Peter Huewe <peterhuewe@gmx.de>
