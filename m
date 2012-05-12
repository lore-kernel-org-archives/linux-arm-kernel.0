From: arnd.bergmann@linaro.org (Arnd Bergmann)
Date: Sat, 12 May 2012 14:53:45 +0000
Subject: [PATCH v9 00/19] Introduce a led trigger for CPU activity and
 consolidate LED driver in ARM
In-Reply-To: <CAK5ve-L4rcAx-=n5u7G0AQzvUG3ir_jzF_ibaSf-EntXAzFUCw@mail.gmail.com>
References: <1335884506-15370-1-git-send-email-bryan.wu@canonical.com>
 <alpine.LFD.2.02.1205101351380.21030@xanadu.home>
 <CAK5ve-L4rcAx-=n5u7G0AQzvUG3ir_jzF_ibaSf-EntXAzFUCw@mail.gmail.com>
Message-ID: <201205121453.45242.arnd.bergmann@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 11 May 2012, Bryan Wu wrote:
> OK, I rebased my patch back on 3.4.0-rc6, please find it here:
> git://kernel.ubuntu.com/roc/linux-2.6/.git leds
> 
> linux-next branch can be also found here:
> git://kernel.ubuntu.com/roc/linux-2.6/.git leds-next
> 
> Arnd, could you please help me to merge? if got any issue, please
> point to me to fix.
> 

Hi Bryan,

I've merged it into a new next/leds branch. I got conflicts with the clps711x
and at91 cleanups that are already in the next/cleanup branch but I think
I resolved them all correctly.  It would be nice if you and/or the maintainers
of those platforms could confirm that.

What is the point of your leds-next branch? We usually don't have a branch like
that because the linux-next tree is rebased every day, and creating a branch based
on it will not be too helpful. Your patches should be in the next linux-next
release, so everyone can just use that for testing now.

	Arnd
