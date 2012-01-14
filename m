From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 14 Jan 2012 08:46:30 +0000
Subject: [PATCH v2 10/15] ARM: highbank: convert to
 twd_local_timer_register() interface
In-Reply-To: <20120114024126.GE1810@S2101-09.ap.freescale.net>
References: <1326479322-6033-1-git-send-email-marc.zyngier@arm.com>
 <1326479322-6033-11-git-send-email-marc.zyngier@arm.com>
 <4F1080EB.1010909@gmail.com>
 <20120114024126.GE1810@S2101-09.ap.freescale.net>
Message-ID: <20120114084630.GN1068@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jan 14, 2012 at 10:41:29AM +0800, Shawn Guo wrote:
> This would just be an indication, since not only SGI but also PPI has
> a read-only Interrupt Configuration Register.  So does the patch below
> make sense?

No, because Tegra can change the configuration of PPIs.
