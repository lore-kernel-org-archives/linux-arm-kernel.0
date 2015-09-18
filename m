From: tony@atomide.com (Tony Lindgren)
Date: Fri, 18 Sep 2015 10:48:18 -0700
Subject: mysterious crashes on OMAP5 uevm
In-Reply-To: <20150908210708.GH4215@atomide.com>
References: <CANOLnOO3NdK1r1jZQtS=TcHEE7SQwhGHh0YsqqoCJpFW3NO05Q@mail.gmail.com>
 <20150908143810.GD4215@atomide.com>
 <CANOLnOODjTaBcL1QzAm7o4YOB=_P-s7JYovu6fhNSqJSV2Bq+Q@mail.gmail.com>
 <20150908210708.GH4215@atomide.com>
Message-ID: <20150918174818.GF8020@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Grazvydas,

* Tony Lindgren <tony@atomide.com> [150908 14:11]:
> * Grazvydas Ignotas <notasas@gmail.com> [150908 13:44]:
> > On Tue, Sep 8, 2015 at 4:38 PM, Tony Lindgren <tony@atomide.com> wrote:
> OK nice to hear you found it. Yeah looks like some runtime
> capability check is needed.
>  
> > > Do you have some easy way to reproduce this issue?
> > 
> > Just moving a browser window around with mouse usually triggers it
> > within a minute.
> 
> OK good to know.

Just FYI, I too was now able to produce it here too moving around
icewweasel for about a minute. And can confirm Russell's patch
fixes the problem.

I'm using i3 tiling window manager here, and don't usually
ever have any floating windows which probably explains why I
did not run into this issue earlier with my lapdock experiments :)

Regards,

Tony
