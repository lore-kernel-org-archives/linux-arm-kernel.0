From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 7 Mar 2011 19:10:00 +0000
Subject: [PATCH 1/2] ARM: l2x0: Errata fix for flush by Wayoperationcan
	cause data corruption
In-Reply-To: <491849bc08797fc8c4d0def52dd6308a@mail.gmail.com>
References: <1298032525-21115-1-git-send-email-santosh.shilimkar@ti.com>
	<1298032525-21115-2-git-send-email-santosh.shilimkar@ti.com>
	<20110227120021.GA15314@n2100.arm.linux.org.uk>
	<20110228101351.GA30781@n2100.arm.linux.org.uk>
	<69dd173e3c7b4d02ef50ceaa19b2343a@mail.gmail.com>
	<000a01cbdcc0$3d0dfeb0$b729fc10$@deacon@arm.com>
	<491849bc08797fc8c4d0def52dd6308a@mail.gmail.com>
Message-ID: <20110307191000.GC2400@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 07, 2011 at 05:55:22PM +0530, Santosh Shilimkar wrote:
> Below is the updated version. Also attached.
> 
> Russell,
> Do you want me to push this to patch system or you can
> apply this one?

Patch system please.
