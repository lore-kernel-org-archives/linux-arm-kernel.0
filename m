From: anarsoul@gmail.com (Vasily Khoruzhick)
Date: Mon, 29 Oct 2012 01:23:45 +0300
Subject: [PATCH 5/5] ARM: PXA: Zipit Z2: Fix backlight PWM device number
In-Reply-To: <201210282301.45790.marex@denx.de>
References: <1351438555-4668-1-git-send-email-anarsoul@gmail.com>
 <1351438555-4668-5-git-send-email-anarsoul@gmail.com>
 <201210282301.45790.marex@denx.de>
Message-ID: <CA+E=qVf_y6Opq9iE1r1J_2QpVsJJXW+3yiy0CrhmhmZ=0T6eqA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 29, 2012 at 1:01 AM, Marek Vasut <marex@denx.de> wrote:
> Dear Vasily Khoruzhick,
>
>> Recent changes to PXA PWM support changed the PXA27X PWM device
>> numbering scheme, so keyboard and LCD backlight is not
>> working anymore on Z2.
>>
>> Fix it and move from legacy to new PWM API.
>
> The proper fix here would be to start moving towards DT.
>
>> Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
> [...]
>
> Best regards,
> Marek Vasut

Dear Marek Vasut,

Sure, but it'll take some time. For now this simple fix is sufficient.
I'll get DT working for pxa27x to familiarize myself with DT.

Regards
Vasily
