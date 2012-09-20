From: santosh.shilimkar@ti.com (Shilimkar, Santosh)
Date: Thu, 20 Sep 2012 23:09:56 +0530
Subject: [PATCH V3 0/8] ARM: OMAP4: Add PMU Support
In-Reply-To: <alpine.DEB.2.00.1209201714260.12583@utopia.booyaka.com>
References: <1347290626-21164-1-git-send-email-jon-hunter@ti.com>
 <alpine.DEB.2.00.1209201714260.12583@utopia.booyaka.com>
Message-ID: <CAMQu2gxdbbfEEGtAGBL5rxUmAPYXgE-Z8Q0mze=NFnrn+3T0QQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Paul,

On Thu, Sep 20, 2012 at 10:47 PM, Paul Walmsley <paul@pwsan.com> wrote:
>
> Hi Jon, Will, Ming, et al.,
>
> Have queued most of these for 3.7 with the exception of the OMAP4430
> CTI-related patches (which look to me like 3.8 material) and the PM
> runtime suspend/resume patch (which looks to me like 3.7-rc material) --
> assuming this series makes it in for 3.7 ...
>
Any reason CTI patches can't be taken now. In fact the CTI patches are
on the list more time than the other ones.

> Apologies in advance if I broke something else in the process.
>
Perf will remain broken on OMAP4 without CTI patches.

Regards
Santosh
