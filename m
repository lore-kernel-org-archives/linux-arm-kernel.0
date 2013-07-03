From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Wed, 03 Jul 2013 20:07:33 +0200
Subject: On common struct clk in clock framework.
In-Reply-To: <CAM2a4uyrX0t-W8hXKROvZgJPSyCY+DaviV-eRVZOhyPx=WNBUw@mail.gmail.com>
References: <CAM2a4uyrX0t-W8hXKROvZgJPSyCY+DaviV-eRVZOhyPx=WNBUw@mail.gmail.com>
Message-ID: <16151917.X00PMOJFZ6@flatron>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wednesday 03 of July 2013 19:05:03 mind entropy wrote:
> Hi,
> 
>    I am reading through mini2440 code and trying to understand
> clocking code. I am getting confused as to whether it uses the common
> clocking framework. In
> https://github.com/torvalds/linux/blob/master/arch/arm/plat-samsung/incl
> ude/plat/clock.h#L42 they define a struct clk. Even in OMAP
> (http://processors.wiki.ti.com/index.php/Clock_Framework_User_Guide#Soft
> ware_Implementation) they have a separate struct clk definition. In the
> common clocking framework shouldn't they be using the common struct clk
> rather than have their own versions of struct clk?

The examples you pointed are not using Common Clock Framework. See 
Documentation/clk.txt and drivers/clk/ for more information about CCF.

As for s3c24xx, CCF driver for the whole platform is already merged for 
Linux 3.11.

Best regards,
Tomasz
