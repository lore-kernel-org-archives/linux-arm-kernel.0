From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 7 Aug 2014 14:54:32 +0100
Subject: [PATCH v2 00/11] pwm: Introduce ST's PWM driver
In-Reply-To: <20140807132050.GC1540@ulmo.nvidia.com>
References: <1405348412-7352-1-git-send-email-lee.jones@linaro.org>
 <20140721123950.GY30888@lee--X1>
 <20140807132050.GC1540@ulmo.nvidia.com>
Message-ID: <20140807135432.GB21618@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 07 Aug 2014, Thierry Reding wrote:

> On Mon, Jul 21, 2014 at 01:39:50PM +0100, Lee Jones wrote:
> > Hi Thierry,
> > 
> > Did you find some time to look at this set?
> 
> Sorry for the long delay. I've applied patches 6-11 to the PWM tree,
> though I've modified patch 6 a little for consistency. The module is
> now named after the Kconfig option (pwm-sti rather than pwm-st). The
> dependencies also seem to be redundant (ARCH_STI already depends on
> OF), though I didn't change that just in case it's required for some
> other reason.
> 
> Anyway, scream if there's anything in the PWM for-next branch that
> needs to be fixed up.

And in time for v3.17.  Nice one, thanks Thierry.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
