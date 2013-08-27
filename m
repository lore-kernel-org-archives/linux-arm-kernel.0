From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 27 Aug 2013 16:48:44 -0700
Subject: [PATCH v2 0/5] Document msm_serial bindings and support newer
 uartdms
In-Reply-To: <20130827232351.GA27119@kroah.com>
References: <1377067686-31957-1-git-send-email-sboyd@codeaurora.org>
 <20130827232351.GA27119@kroah.com>
Message-ID: <521D3ADC.6050703@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/27/13 16:23, Greg Kroah-Hartman wrote:
> On Tue, Aug 20, 2013 at 11:48:01PM -0700, Stephen Boyd wrote:
>> This patchset aligns the msm_serial driver more with downstream usage and
>> also documents the msm_serial driver's DT binding. Along the way we
>> update the clock names and add support for newer UARTDM hardware that
>> isn't part of a GSBI and make the console layer use the extra registers in
>> UARTDM.
>>
>> Changes since v1:
>>  * Dropped _clk postfix from {core,iface}_clk
>>  * Split DT binding into two files
>>  * Renamed DT binding files to match compatible strings
>>  * Fixed up DT review comments
>>  * Added new patch 5/5 (more than 1 char for UARTDM)
> I took patches 1, 3, and 5 from this series, as it seems that the dt
> bindings are still being discussed.

Thanks Greg. I'll resend the patches right now. I got sidetracked on
other things.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
