From: thierry.reding@gmail.com (Thierry Reding)
Date: Thu, 7 Aug 2014 15:55:55 +0200
Subject: [PATCH v2 00/11] pwm: Introduce ST's PWM driver
In-Reply-To: <20140807135432.GB21618@lee--X1>
References: <1405348412-7352-1-git-send-email-lee.jones@linaro.org>
 <20140721123950.GY30888@lee--X1>
 <20140807132050.GC1540@ulmo.nvidia.com>
 <20140807135432.GB21618@lee--X1>
Message-ID: <20140807135554.GB27417@ulmo.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 07, 2014 at 02:54:32PM +0100, Lee Jones wrote:
> On Thu, 07 Aug 2014, Thierry Reding wrote:
> 
> > On Mon, Jul 21, 2014 at 01:39:50PM +0100, Lee Jones wrote:
> > > Hi Thierry,
> > > 
> > > Did you find some time to look at this set?
> > 
> > Sorry for the long delay. I've applied patches 6-11 to the PWM tree,
> > though I've modified patch 6 a little for consistency. The module is
> > now named after the Kconfig option (pwm-sti rather than pwm-st). The
> > dependencies also seem to be redundant (ARCH_STI already depends on
> > OF), though I didn't change that just in case it's required for some
> > other reason.
> > 
> > Anyway, scream if there's anything in the PWM for-next branch that
> > needs to be fixed up.
> 
> And in time for v3.17.  Nice one, thanks Thierry.

Barely...

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140807/9f64564c/attachment.sig>
