From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 26 Jul 2012 12:36:41 +0100
Subject: [PATCH 00/21] Some fixes and DT enablement for ux500 audio
In-Reply-To: <20120726112848.GX3099@opensource.wolfsonmicro.com>
References: <1343298534-13611-1-git-send-email-lee.jones@linaro.org>
 <20120726112848.GX3099@opensource.wolfsonmicro.com>
Message-ID: <50112BC9.1070100@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 26/07/12 12:28, Mark Brown wrote:
> On Thu, Jul 26, 2012 at 11:28:33AM +0100, Lee Jones wrote:
>> This patch-set sees some code reinforcement surrounding the recently
>> accepted MOP500 MSP, PCM, AB8500 CODEC and ux500 Audio Machine Driver.
>> It contains some extra error checking pertaining to the ux500 specific
>> drivers themselves, along with bugfixes for issues in core SoC Audio
>> code happened upon along the way. There are also a couple of minor
>> clean-ups relating to ux500 platform code, which are hitching a ride
>> for ease of status tracking.
>
> Please restructure this so that the actual error fixes (which should go
> into 3.6) are before the random cleanups (which should go into 3.7)
> rather than mixing them together.

I can.

 > It'd also be helpful if you could
> split out changes to the different subsystems separately when there's no
> overlap (which mostly looks to be the case here).

I can to this too, but you will still have overlap between arch/arm and 
sound/soc. The only other subsystem in the patch-set is MFD.




-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
