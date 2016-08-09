From: randy.li@rock-chips.com (Randy Li)
Date: Tue, 9 Aug 2016 18:06:33 +0800
Subject: [PATCH] ARM: dts: add rk3288-firefly-reload
In-Reply-To: <CAFLEztTROearSEcgzV3EVHFcRcMQpLhAQ6BXP-dDyRDAWybaxg@mail.gmail.com>
References: <1549971.ctkvOGm2xW@diego> <2868781.4x2gJCRbLH@diego>
 <413ebccd-e8d6-1401-3065-f9a63b4d66e6@rock-chips.com>
 <1815189.oGy6GHMbyM@phil>
 <CAFLEztQ1pa-CCbC8c8+VJ_kg8RyPOb-UHZiKBZffKEw9zyx9Zg@mail.gmail.com>
 <CAFLEztTROearSEcgzV3EVHFcRcMQpLhAQ6BXP-dDyRDAWybaxg@mail.gmail.com>
Message-ID: <C2BE77CA-A59B-4128-8802-E3E36FACDABA@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



??? iPad ??

> ?? <jacobchen110@gmail.com> ? 2016?8?9? ??6:02 ???
> 
> well?it has already been added....
> 
> The root cause is not act8846. Firefly have a bug with sdmmc and it
> seems they didn't fix it in firefly-reload.
> 
> http://bbs.t-firefly.com/forum.php?mod=viewthread&tid=256
Yes, Jacob is right. Those high speed options need the voltage down to 1.8v. They should be removed.
