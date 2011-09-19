From: hemantp@ti.com (Pedanekar, Hemant)
Date: Mon, 19 Sep 2011 09:36:17 +0530
Subject: [PATCH] ARM: OMAP: Add support for dmtimer v2 ip (Re: [PATCH
	v15 06/12] OMAP: dmtimer: switch-over to platform device driver)
In-Reply-To: <20110917013531.GB2937@atomide.com>
References: <1315516098-29761-1-git-send-email-tarun.kanti@ti.com>
	<1315516098-29761-7-git-send-email-tarun.kanti@ti.com>
	<20110914214533.GA30941@atomide.com>
	<CAC83ZvJgPYb3JbWT4SKXpQvq-vdKK4b6hd6E-ik5uyRCqgwWsg@mail.gmail.com>
	<B85A65D85D7EB246BE421B3FB0FBB59302575A050D@dbde02.ent.ti.com>
	<20110915165810.GA2284@atomide.com> <20110915170548.GB2284@atomide.com>
	<CAC83ZvKGoucZ=xQSa7GEk7Gg8jcFBQE==1a6m4=+nzDRrsw+jw@mail.gmail.com>
	<CAC83ZvKXEb7MTujP4JqhrPeysYxQcLF+BV-J9tpYoRwWGVZ8_Q@mail.gmail.com>
	<20110917013531.GB2937@atomide.com>
Message-ID: <2A3DCF3DA181AD40BDE86A3150B27B6B03B4C80288@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tony Lindgren wrote on Saturday, September 17, 2011 7:06 AM:

> device driver)
> 
> * DebBarma, Tarun Kanti <tarun.kanti@ti.com> [110916 01:56]:
>> [...]
> 
> Afzal, care to check if that works for AM335X/TI816X/TI814X?
> It tried it briefly with omap4 gptimer3 as the clockevent and
> CONFIG_LOCAL_TIMER disabled. 
> 
> The patch is against the current cleanup branch in linux-omap
> tree.
> 
> Regards,
> 
> Tony
> 
> 
> From: Tony Lindgren <tony@atomide.com>
> Date: Fri, 16 Sep 2011 15:44:20 -0700
> Subject: [PATCH] ARM: OMAP: Add support for dmtimer v2 ip
> 
[...]

Tony,
Kernel boots fine on TI816X (should also boot on TI814X) with your patch
and patches (including OSC clock fix) from series
http://www.spinics.net/lists/linux-omap/msg57011.html  

Thanks.

   Hemant
