From: paul@pwsan.com (Paul Walmsley)
Date: Mon, 5 Jan 2015 22:19:56 +0000 (UTC)
Subject: [PATCH] ARM: OMAP2+: hwmod: Fix _wait_target_ready() for hwmods
 without sysc
In-Reply-To: <54AAEBCC.2030900@ti.com>
References: <1418917790-1791-1-git-send-email-rogerq@ti.com>
 <5492F84E.7020706@ti.com>
 <alpine.DEB.2.02.1501020654050.27058@utopia.booyaka.com>
 <54AA4CD4.40105@ti.com> <54AAEBCC.2030900@ti.com>
Message-ID: <alpine.DEB.2.02.1501052219240.28771@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 5 Jan 2015, Suman Anna wrote:

> That's right, the test was present even before 6423d6df1440, I merely
> made this a block.

Indeed, I misread the commit.  Sorry about ihat.


- Paul
