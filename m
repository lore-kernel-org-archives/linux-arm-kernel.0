From: cbouatmailru@gmail.com (Anton Vorontsov)
Date: Thu, 6 Dec 2012 07:38:33 -0800
Subject: [PATCH resend 0/4] ARM: KDB FIQ debugger
In-Reply-To: <20121206151726.GA23394@lizard>
References: <20121123002957.GA31679@lizard.mcd25758.sjc.wayport.net>
 <20121206151726.GA23394@lizard>
Message-ID: <20121206153832.GA27012@lizard>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 06, 2012 at 07:17:26AM -0800, Anton Vorontsov wrote:
> On Thu, Nov 22, 2012 at 04:29:57PM -0800, Anton Vorontsov wrote:
> > Hello Andrew, Russell,
> > 
> > The KDB/NMI core support has been merged into v3.7-rc1, so the only ARM
> > bits are pending now.
> > 
> > I addressed all the comments ~two month ago, and since then just resending
> > these patches. I know we're all busy, so no blaming. :) But then let's
> > pass this via -mm?
> 
> Guys, could someone take a look at this?.. Considering the low impact of
> this series (it mostly adds code, and the only modification part the one
> that just moves things around), maybe it still has some chance to get into
> 3.9?

Oops, I mean 3.8, of course. :)
