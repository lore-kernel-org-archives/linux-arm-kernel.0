From: horms@verge.net.au (Simon Horman)
Date: Thu, 29 Jan 2015 09:30:57 +0900
Subject: [PATCH] ARM: shmobile: henninger: rename board to Porter
In-Reply-To: <54C8E718.7060504@cogentembedded.com>
References: <2481726.lh33apx2TG@wasted.cogentembedded.com>
 <CAMuHMdW3NmzGxGa9DOHpk4Evjg=+bduUPiMoRZT9Ko7+jNp-Nw@mail.gmail.com>
 <54C8E718.7060504@cogentembedded.com>
Message-ID: <20150129003057.GB18731@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 28, 2015 at 04:41:44PM +0300, Sergei Shtylyov wrote:
> Hello.
> 
> On 1/25/2015 10:30 PM, Geert Uytterhoeven wrote:
> 
> >>Renesas has made some changes to the Henninger low cost board hardware and at
> >>the same time decided to  rename the board  to Porter.
> 
> >Which changes?
> 
>   I don't have a list ready, sorry. One thing I know is that HDMI chip is
> different (the same as on Koelsch now); we don't support it yet...

This sounds more like a new board than an update. I don't have any strong
opinions about this at this time but perhaps it would make more sense to
handle this as two steps: adding a new board and removing an old one.

> >They're not reflected in the new DTS?
> 
>    Not yet.
> 
> >>Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> 
> >>---
> >>This patch is against 'renesas-devel-20150123-v3.19-rc5' tag of Simon Horman's
> >>'renesas.git' repo.
> >>
> >>  arch/arm/boot/dts/Makefile                                     |  2 +-
> >>  .../arm/boot/dts/{r8a7791-henninger.dts => r8a7791-porter.dts} | 10 +++++-----
> >>  2 files changed, 6 insertions(+), 6 deletions(-)
> >>  rename arch/arm/boot/dts/{r8a7791-henninger.dts => r8a7791-porter.dts} (96%)
> 
> >You forgot to update Documentation/devicetree/bindings/arm/shmobile.txt
> 
>    No wonder -- I had no idea it is listed there...
> 
> >Gr{oetje,eeting}s,
> 
> >                         Geert
> 
> WBR, Sergei
> 
