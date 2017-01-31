From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 31 Jan 2017 11:44:18 +0100
Subject: [PATCHv2 3/3] arm64: dts: marvell: adjust name of sd-mmc-gop
 clock in syscon
In-Reply-To: <1482316017-22154-4-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1482316017-22154-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1482316017-22154-4-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20170131114418.46e23bd4@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Wed, 21 Dec 2016 11:26:57 +0100, Thomas Petazzoni wrote:
> This commit adjusts the names of gatable clock #18 of the Marvell Armada
> CP110 system controller. This clock not only controls SD/MMC, but also
> the GOP (Group Of Ports) used for networking. So the clock is renamed to
> {cpm,cps}-sd-mmc-gop instead of {cpm,cps}-sd-mmc.
> 
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

Gr?gory, since patches 1/3 and 2/3 of this series have been applied,
could you take this PATCH 3/3 ?

Thanks!

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
