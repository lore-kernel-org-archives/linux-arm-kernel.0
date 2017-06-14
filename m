From: leo.yan@linaro.org (Leo Yan)
Date: Wed, 14 Jun 2017 14:22:29 +0800
Subject: [PATCH 00/17] coresight: next v4.12-rc4
In-Reply-To: <20170613161712.f1f3cac734939d8728c7ed77@arm.com>
References: <1496693718-9191-1-git-send-email-mathieu.poirier@linaro.org>
 <20170609175339.28d1d4d5a6c91a9e16c16bf7@arm.com>
 <CANLsYky8XLbOwinxVc2xKaNzhkpUOX0NsNxrFF4=MsjzC3iY1g@mail.gmail.com>
 <20170613161712.f1f3cac734939d8728c7ed77@arm.com>
Message-ID: <20170614062229.GA28496@leoy-ThinkPad-T440>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kim,

On Tue, Jun 13, 2017 at 04:17:12PM -0500, Kim Phillips wrote:

[...]

> > > Also, do the current juno platforms not have CPU debug modules?  I'd
> > > like to test the new driver.
> > 
> > By all means - Leo pointed out the patch adding the CPU debug entries in
> > the DT  file for Juno.
> 
> Thanks, I applied it, was able to
> toggle /sys/kernel/debug/coresight_cpu_debug/enable, but wasn't sure
> how to trigger the cpu debug output...

You could trigger panic flow with command, then can see CPU debug output:
echo c > /proc/sysrq-trigger

Thanks,
Leo Yan
