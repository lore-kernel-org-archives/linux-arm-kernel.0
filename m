From: prylowski@metasoft.pl (Rafal Prylowski)
Date: Wed, 21 Mar 2012 08:47:22 +0100
Subject: [PATCH] ep93xx: Implement double buffering for M2M DMA channels
In-Reply-To: <20120321070707.GA25052@mwesterb-mobl.ger.corp.intel.com>
References: <4F683B36.8090101@metasoft.pl>
 <20120321070707.GA25052@mwesterb-mobl.ger.corp.intel.com>
Message-ID: <4F69878A.4070901@metasoft.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2012-03-21 08:07, Mika Westerberg wrote:
> 
> Which tree this is supposed to apply? I tried both mainline and -next and it
> doesn't apply cleanly there.
> 

I prepared it for git://git.infradead.org/users/vkoul/slave-dma.git tree.
Also, I checked that it applies cleanly to:
git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git
(I'm assuming this is mainline).
