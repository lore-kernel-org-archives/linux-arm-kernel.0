From: fu.wei@linaro.org (Fu Wei)
Date: Thu, 8 Dec 2016 11:16:21 +0800
Subject: [Linaro-acpi] [PATCH v17 08/15]
 clocksource/drivers/arm_arch_timer:
 move arch_timer_needs_of_probing into DT init call
In-Reply-To: <CAOZdJXU7Lg66RKvA=sYtUXUdwLLbh9FtcW0_U-fmjaztnqS3Ng@mail.gmail.com>
References: <20161125084623.22515-9-fu.wei@linaro.org>
 <201611252221.UyJ9iWPV%fengguang.wu@intel.com>
 <CADyBb7uAObQn_JVp_qw9+7POiqUctdzy3cYLsb0rk-JMX5W1uw@mail.gmail.com>
 <CAOZdJXU7Lg66RKvA=sYtUXUdwLLbh9FtcW0_U-fmjaztnqS3Ng@mail.gmail.com>
Message-ID: <CADyBb7vAfMGV5ERFqAbwo4v4BhJv5s_-x4DXmdvy=iUacBzJWQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Timur,

On 8 December 2016 at 01:25, Timur Tabi <timur@codeaurora.org> wrote:
> On Fri, Nov 25, 2016 at 9:06 AM, Fu Wei <fu.wei@linaro.org> wrote:
>>
>> a "+ int ret;" should be move from [12/15] to here, I have fix the
>> problem in my repo, it would happen in next patchset
>>
>> https://git.linaro.org/people/fu.wei/linux.git/log/?h=topic-gtdt-wakeup-timer_upstream_v18_devel
>
> Fu, please post v18 to the mailing list so that it can be picked up
> for 4.10 (if it's not too late already).

Great thanks for your suggestion!  :-)
yes, you are right, I would love to post v18 ASAP.

But I am still waiting for more feedback from the maintainers.
For Now, the only feedback is this fix from "kbuild test robot" :-(

>
> --
> Qualcomm Innovation Center, Inc.
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project.



-- 
Best regards,

Fu Wei
Software Engineer
Red Hat
