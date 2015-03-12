From: horms@verge.net.au (Simon Horman)
Date: Thu, 12 Mar 2015 17:14:45 +0900
Subject: [PATCH 0/2] ARM: shmobile: Correct SYSCIER values
In-Reply-To: <CAMuHMdUuv6YrEUsCpbuZwHUy_a-+sK8O=q8k-OZLZRytKv7gyA@mail.gmail.com>
References: <1426132537-31606-1-git-send-email-horms+renesas@verge.net.au>
 <CAMuHMdUuv6YrEUsCpbuZwHUy_a-+sK8O=q8k-OZLZRytKv7gyA@mail.gmail.com>
Message-ID: <20150312081442.GA4295@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 12, 2015 at 09:03:04AM +0100, Geert Uytterhoeven wrote:
> Hi Simon,
> 
> On Thu, Mar 12, 2015 at 4:55 AM, Simon Horman
> <horms+renesas@verge.net.au> wrote:
> > this short series corrects the SYSCIER value used on the r9a7790 and
> > r8a7791 SoCs.
> 
> Thanks!
> 
> Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
> 
> > I am not aware of any run-time effect of these changes.
> 
> They only matter when powering up/down SYSC PM Domains, which is not
> yet implemented for R-Car Gen2.

Thanks, good to know.

FWIW the values in these patches are the ones that
you supplied in another email thread. However, I did
verify them against (my reading of) the documentation.
