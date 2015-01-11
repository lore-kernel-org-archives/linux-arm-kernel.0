From: egtvedt@samfundet.no (Hans-Christian Egtvedt)
Date: Sun, 11 Jan 2015 13:10:12 +0100
Subject: [PATCH] avr32: remove fake at91 cpu identification
In-Reply-To: <1420941616-2777-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1420941616-2777-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <20150111121012.GB4050@samfundet.no>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Around Sun 11 Jan 2015 03:00:16 +0100 or thereabout, Alexandre Belloni wrote:
> cpu_is_at91* are not used in any driver outside mach-at91. Remove those useless
> definitions.

Great, thank you for cleaning.

> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
>

Acked-by: Hans-Chrisitan Egtvedt <egtvedt@samfundet.no>

> ---
> 
> Hans-Christian,
> 
> If you want, I guess that one could go through the at91 tree. Unless you have
> more material and you want to do a pull request for 3.20.

I have another patch in the pipe wiring up syscalls for AVR32, so I'll push
this through my tree for 3.20.

>  arch/avr32/mach-at32ap/include/mach/cpu.h | 26 +-------------------------
>  1 file changed, 1 insertion(+), 25 deletions(-)

<snipp diff>

-- 
HcE
