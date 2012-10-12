From: richardcochran@gmail.com (Richard Cochran)
Date: Fri, 12 Oct 2012 19:11:44 +0200
Subject: Booting vanilla kernel on the beaglebone
In-Reply-To: <EB1619762EAF8B4E97A227FB77B7E0293E9F451D@DBDE01.ent.ti.com>
References: <20121011050948.GA2577@netboy.at.omicron.at>
 <5076B2FE.8040000@ti.com>
 <EB1619762EAF8B4E97A227FB77B7E0293E9F451D@DBDE01.ent.ti.com>
Message-ID: <20121012171144.GA2387@netboy.at.omicron.at>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 11, 2012 at 09:20:24PM +0000, N, Mugunthan V wrote:
> 
> I have a working branch for CPSW which is based on 3.5.0-rc6 in the following git repo
> Repo: https://github.com/hvaibhav/am335x-linux.git
> Branch: am335x-linux-next-master-cpsw

It looks like the last five commits in that branch are relevant:

86116a8 ARM: OMAP2+: omap2plus_defconfig: Enable CPSW support
020c28d arm/dts: am33xx: Add cpsw and mdio module nodes for AM33XX
e36f449 net: cpsw: Add parent<->child relation support between cpsw and mdio
011d593 net: davinci_mdio: Fix type mistake in calling runtime-pm api
7179021 ARM: OMAP3+: hwmod: Add AM33XX HWMOD data for davinci_mdio

Are there any others buried deeper in there?

Are you submitting the needed patches for 3.7-rc1?

Thanks,
Richard
