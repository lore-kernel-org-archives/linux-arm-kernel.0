From: g.liakhovetski@gmx.de (Guennadi Liakhovetski)
Date: Wed, 11 Sep 2013 10:15:53 +0200 (CEST)
Subject: "cpufreq: fix serialization issues with freq change notifiers"
 breaks cpufreq too
In-Reply-To: <CAKohpokaHU0V86DPB7nEQ8ndwu_mJ_x_Uz47XPHZeyAW3hcP_w@mail.gmail.com>
References: <Pine.LNX.4.64.1309091656200.6602@axis700.grange>
 <CAKohponZ+FnzqXYMbBzbun0-1iQMi2fS4syrEBC_MdF41vLCeA@mail.gmail.com>
 <Pine.LNX.4.64.1309101656150.16010@axis700.grange>
 <CAKohpomBBKLhNemVUpUHAftGhPJJe+ZB7T_9UYLD7LwpR1nK0g@mail.gmail.com>
 <Pine.LNX.4.64.1309101740120.16010@axis700.grange>
 <CAKohpomK7Y_6aLMA3B+hZrtgYq9U89ihgkbvYWA3BsKN3gJD3g@mail.gmail.com>
 <Pine.LNX.4.64.1309101853170.16010@axis700.grange>
 <CAKohpokaHU0V86DPB7nEQ8ndwu_mJ_x_Uz47XPHZeyAW3hcP_w@mail.gmail.com>
Message-ID: <Pine.LNX.4.64.1309111015190.26942@axis700.grange>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 11 Sep 2013, Viresh Kumar wrote:

> On 10 September 2013 22:37, Guennadi Liakhovetski <g.liakhovetski@gmx.de> wrote:
> > On Tue, 10 Sep 2013, Viresh Kumar wrote:
> >> Quite straight forward actually..
> >
> > Apparently, not quite.
> 
> I overlooked the situation where we return early from ->target() routines.. :(
> 
> Please try attached patches, I will repost them later (once I am able to
> convince Rafael that these are really important :) )

I'd rather wait until Rafael is convinced, then we'll see.

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
