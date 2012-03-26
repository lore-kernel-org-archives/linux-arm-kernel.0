From: prylowski@metasoft.pl (Rafal Prylowski)
Date: Mon, 26 Mar 2012 08:44:34 +0200
Subject: [PATCH] ep93xx: Implement double buffering for M2M DMA channels
In-Reply-To: <20120324073207.GD5812@mwesterb-mobl.ger.corp.intel.com>
References: <4F683B36.8090101@metasoft.pl>
 <20120321193836.GC3740@mwesterb-mobl.ger.corp.intel.com>
 <ADE657CA350FB648AAC2C43247A983F0020696D48E3E@AUSP01VMBX24.collaborationhost.net>
 <20120323070446.GC5812@mwesterb-mobl.ger.corp.intel.com>
 <ADE657CA350FB648AAC2C43247A983F0020696D48EEB@AUSP01VMBX24.collaborationhost.net>
 <20120324073207.GD5812@mwesterb-mobl.ger.corp.intel.com>
Message-ID: <4F701052.5000509@metasoft.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2012-03-24 08:32, Mika Westerberg wrote:
> Please try it. The point there was that we have a problem in ep93xx VIC/DMA
> code but it is totally different thing and not related to Rafal's patch. We
> can sort the VIC thing out separately IMHO. ep93xx dma in 3.3 is broken
> regardless this patch.

I think, that we can't be 100% sure that these two problems are not related
at all. If some changes to VIC/ep93xx interrupt handling etc will be send
to list, I'll test them in my configuration without my patch. If it will
help (to fix the problem I'm observing also in 3.2), then double buffering
for M2M could be much simplier.

Now, I'm trying to test mmc_spi in ep93xx and let you know what the results
are.
