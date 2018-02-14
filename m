From: tony@atomide.com (Tony Lindgren)
Date: Wed, 14 Feb 2018 10:59:24 -0800
Subject: [PATCH v7 3/9] arm: omap: Move dmtimer.h out of plat-omap
In-Reply-To: <37f28584-20c2-51c1-e476-75ef81f03af6@ti.com>
References: <1515478987-5786-1-git-send-email-j-keerthy@ti.com>
 <1515478987-5786-4-git-send-email-j-keerthy@ti.com>
 <1c9f5c72-f589-d7c7-399f-ef55ecb828a0@ti.com>
 <37f28584-20c2-51c1-e476-75ef81f03af6@ti.com>
Message-ID: <20180214185924.GR6364@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Keerthy <j-keerthy@ti.com> [180214 04:51]:
> On Tuesday 13 February 2018 07:36 AM, Suman Anna wrote:
> > These headers are actually not needed in the first-place since we no
> > longer create any non-DT timer devices. I have submitted a series to
> > cleanup the presence of this header file, as part of a larger hwmod data
> > cleanup series.
> 
> I will rebase my series on top of your clean up series. Thanks for clean
> ups.

I've now pushed Suman's series into omap-for-v4.17/soc and
merged it into my for-next. So please rebase your updated
patches against omap-for-v4.17/soc.

Thanks,

Tony
