From: avinashphilip@ti.com (Philip, Avinash)
Date: Mon, 8 Apr 2013 09:09:59 +0000
Subject: [PATCH v3 3/3] ARM: davinci: da850: add EHRPWM & ECAP DT node
In-Reply-To: <515A97DE.1080403@ti.com>
References: <1364197789-16783-1-git-send-email-avinashphilip@ti.com>
 <1364197789-16783-4-git-send-email-avinashphilip@ti.com>
 <515A97DE.1080403@ti.com>
Message-ID: <518397C60809E147AF5323E0420B992E3EAA91B6@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 02, 2013 at 14:03:34, Nori, Sekhar wrote:
> On 3/25/2013 1:19 PM, Philip Avinash wrote:
> > Add da850 EHRPWM & ECAP DT node.
> > Also adds OF_DEV_AUXDATA for EHRPWM & ECAP driver to use EHRPWM & ECAP
> > clock.
> 
> This looks fine to me but I will wait for the bindings to get accepted
> before taking this one.

Sekhar,

Binding document got accepted in PWM tree [1].
Can you accept this patch?

1. https://gitorious.org/linux-pwm

Thanks
Avinash

> 
> Thanks,
> Sekhar
> 
