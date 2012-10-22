From: paul@pwsan.com (Paul Walmsley)
Date: Mon, 22 Oct 2012 17:06:54 +0000 (UTC)
Subject: [PATCH 0/7] ARM: OMAP: second set of PRM/CM/CGRM cleanup patches
 for 3.8
In-Reply-To: <5085389F.6070106@ti.com>
References: <20121016012448.21844.92339.stgit@dusk.lan>
 <5085389F.6070106@ti.com>
Message-ID: <alpine.DEB.2.00.1210221641310.13464@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 22 Oct 2012, Benoit Cousson wrote:

> What is CGRM? Is it a typo?

That's the OMAP1 Clock Generation and Reset Module that contains the 
ARM_SYSST register:

http://www.ti.com/lit/ug/spru678a/spru678a.pdf

- Paul
