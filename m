From: soren.brinkmann@xilinx.com (=?utf-8?B?U8O2cmVu?= Brinkmann)
Date: Thu, 27 Feb 2014 09:52:17 -0800
Subject: [PATCH v4 0/4] ARM: zynq: cpufreq support
In-Reply-To: <1392851684-29950-1-git-send-email-soren.brinkmann@xilinx.com>
References: <1392851684-29950-1-git-send-email-soren.brinkmann@xilinx.com>
Message-ID: <3402bb7c-3dec-403a-9356-65af803e1b0a@AM1EHSMHS017.ehs.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Daniel, Michal,

On Wed, 2014-02-19 at 03:14PM -0800, Soren Brinkmann wrote:
> Hi,
> 
> another iteration of this series. The patches are the same as in v3, but
> the series shrank a bit. I rebased this series on tip/timers/core, hence
> the two patches for the clockevent core fell out, since Thomas already
> applied those.
> Additionally I removed the patch 'clocksource/cadence_ttc: Use only one
> counter'. Thomas brought up some questions regarding that patch which
> need to be investigated. Since it is not required for the rest of this
> series, I just dropped it for now.
> 
> 	Thanks,
> 	S?ren
> 
> Soren Brinkmann (4):
>   clocksource/cadence_ttc: Call clockevents_update_freq() with IRQs
>     enabled
>   clocksource/cadence_ttc: Overhaul clocksource frequency adjustment
>   arm: zynq: Don't use arm_global_timer with cpufreq
>   arm: zynq: Add support for cpufreq

Any comments? I think most of these should be pretty straight forward
and it would be nice to get some ACKs - or tell me what's wrong. :)
'clocksource/cadence_ttc: Overhaul clocksource frequency adjustment'
might deserve a more thorough review.

	Thanks,
	S?ren
