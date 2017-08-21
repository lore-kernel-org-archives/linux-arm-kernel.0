From: kim.phillips@arm.com (Kim Phillips)
Date: Mon, 21 Aug 2017 18:31:39 -0500
Subject: [PATCH 00/17] coresight: next v4.12-rc4
In-Reply-To: <20170615155054.GN28496@leoy-ThinkPad-T440>
References: <1496693718-9191-1-git-send-email-mathieu.poirier@linaro.org>
 <20170609175339.28d1d4d5a6c91a9e16c16bf7@arm.com>
 <CANLsYky8XLbOwinxVc2xKaNzhkpUOX0NsNxrFF4=MsjzC3iY1g@mail.gmail.com>
 <20170613161712.f1f3cac734939d8728c7ed77@arm.com>
 <20170614062229.GA28496@leoy-ThinkPad-T440>
 <20170614223453.3357117a7f25ee68924a071c@arm.com>
 <d9b1121b-6e04-dfe7-b75b-9fbc6129a907@arm.com>
 <20170615092246.bc4fb71637e482a118199864@arm.com>
 <20170615155054.GN28496@leoy-ThinkPad-T440>
Message-ID: <20170821183139.76faaa5fb55962815616395b@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 15 Jun 2017 23:50:54 +0800
Leo Yan <leo.yan@linaro.org> wrote:

> Looked into the code, and I must apologize I have not verified the
> command when wrote the doc. As you pointed out, the closing file
> operation releases the constraint for PM QoS.
> 
> Below command can work (I tested):
> exec 3<> /dev/cpu_dma_latency; echo 0 >&3
> 
> Will commit one patch for this.

Did I miss this?  Where was it posted?

Thanks,

Kim
