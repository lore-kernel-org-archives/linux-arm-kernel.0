From: tarun.kanti@ti.com (DebBarma, Tarun Kanti)
Date: Thu, 22 Sep 2011 11:39:13 +0530
Subject: [PATCH v16 00/12] OMAP: dmtimer: adaptation to platform_driver
In-Reply-To: <20110922005930.GN2937@atomide.com>
References: <1316518227-28116-1-git-send-email-tarun.kanti@ti.com>
	<20110922005930.GN2937@atomide.com>
Message-ID: <CAC83Zv+aFu6u7TezD0NA3UHf9DMtW0AsP15jB1FFn8avEwY7CQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 22, 2011 at 6:29 AM, Tony Lindgren <tony@atomide.com> wrote:
> Hi Tarun,
>
> * Tarun Kanti DebBarma <tarun.kanti@ti.com> [110920 03:57]:
>> Adaptation of dmtimer code to platform driver using omap_device and
>> omap_hwmod abstraction. It also include pm-runtime and off-mode support.
>
> I've applied these into dmtimer branch with some changes to simplify
> things further. I've also merged it into linux-omap master branch
> for further testing.
>
> I'll reply to your patches with the changes I've done. Care give the
> dmtimer branch a try and see if I've missed something?
Sure, I will go through the changes and do testing on it.
--
Tarun
>
> Regards,
>
> Tony
>
