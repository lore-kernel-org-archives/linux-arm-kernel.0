From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 12 May 2015 18:05:39 +0200
Subject: [PATCH 2/8] dmaengine: mv_xor: add support for a38x command in
 descriptor mode
In-Reply-To: <20150512155824.GJ19927@lunn.ch>
References: <1431445063-20226-1-git-send-email-maxime.ripard@free-electrons.com>
 <1431445063-20226-3-git-send-email-maxime.ripard@free-electrons.com>
 <20150512174936.284783d4@free-electrons.com>
 <20150512155824.GJ19927@lunn.ch>
Message-ID: <20150512180539.4ea5d158@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Andrew,

On Tue, 12 May 2015 17:58:24 +0200, Andrew Lunn wrote:

> A quick grep for marvell,orion, marvell,kirkwood and marvell,dove
> suggests it should have the - if we want to be consistent with older
> Marvell devices. As you said, starting with marvell,armanda it gets
> pretty inconsistent :-(

Yes, with the "-" would be better IMO.

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
