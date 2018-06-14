From: horms@verge.net.au (Simon Horman)
Date: Thu, 14 Jun 2018 09:20:00 +0200
Subject: [PATCH v2] arm64: dts: renesas: condor/v3hsk: specify Ethernet
 PHY IRQs
In-Reply-To: <9d6f18ad-47d1-eb81-1a86-d124ca03e1c9@cogentembedded.com>
References: <4acc208e-c593-1e8a-00ca-fc9a5574074e@cogentembedded.com>
 <42861d8f-3570-03b9-987c-bb15fa92a9c7@cogentembedded.com>
 <9d6f18ad-47d1-eb81-1a86-d124ca03e1c9@cogentembedded.com>
Message-ID: <20180614071959.z6mt55lfqptb7hmg@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 13, 2018 at 07:44:02PM +0300, Sergei Shtylyov wrote:
> On 06/13/2018 07:42 PM, Sergei Shtylyov wrote:
> 
> > Specify Ethernet PHY IRQs in the Condor/V3HSK board device trees, now that
> > we have the GPIO support (previously phylib had  to resort to polling).
> > 
> > Based on the original (and large) patch by Vladimir Barinov.
> > 
> > Signed-off-by: Vladimir Barinov <vladimir.barinov@cogentembedded.com>
> > Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> > 
> > ---
> 
>    Forgot to add the the patch is against the 'renesas-devel-20180613-v4.17' tag.
> 

Thanks Sergei, applied.
