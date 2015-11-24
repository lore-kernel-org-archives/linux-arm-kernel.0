From: horms@verge.net.au (Simon Horman)
Date: Tue, 24 Nov 2015 11:16:28 +0900
Subject: [PATCH 1/2] ARM: shmobile: alt: Correct scif2 pfc
In-Reply-To: <565305BD.5070306@cogentembedded.com>
References: <1448263004-14548-1-git-send-email-horms+renesas@verge.net.au>
 <1448263004-14548-2-git-send-email-horms+renesas@verge.net.au>
 <565305BD.5070306@cogentembedded.com>
Message-ID: <20151124021628.GA20338@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 23, 2015 at 03:25:33PM +0300, Sergei Shtylyov wrote:
> Hello.
> 
> On 11/23/2015 10:16 AM, Simon Horman wrote:
> 
> >0c9400fab882 ("Merge branch 'heads/dt-for-v4.5' into next") introduced
> >pfc pins to the alt device tree but did not reference them. This patch
> 
>    Merge introduced? I thought there was a concrete commit doing that...

Indeed, I will fix that.
