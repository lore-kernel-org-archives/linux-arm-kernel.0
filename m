From: timur@codeaurora.org (Timur Tabi)
Date: Wed, 7 Dec 2016 11:25:31 -0600
Subject: [Linaro-acpi] [PATCH v17 08/15]
 clocksource/drivers/arm_arch_timer:
 move arch_timer_needs_of_probing into DT init call
In-Reply-To: <CADyBb7uAObQn_JVp_qw9+7POiqUctdzy3cYLsb0rk-JMX5W1uw@mail.gmail.com>
References: <20161125084623.22515-9-fu.wei@linaro.org>
 <201611252221.UyJ9iWPV%fengguang.wu@intel.com>
 <CADyBb7uAObQn_JVp_qw9+7POiqUctdzy3cYLsb0rk-JMX5W1uw@mail.gmail.com>
Message-ID: <CAOZdJXU7Lg66RKvA=sYtUXUdwLLbh9FtcW0_U-fmjaztnqS3Ng@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 25, 2016 at 9:06 AM, Fu Wei <fu.wei@linaro.org> wrote:
>
> a "+ int ret;" should be move from [12/15] to here, I have fix the
> problem in my repo, it would happen in next patchset
>
> https://git.linaro.org/people/fu.wei/linux.git/log/?h=topic-gtdt-wakeup-timer_upstream_v18_devel

Fu, please post v18 to the mailing list so that it can be picked up
for 4.10 (if it's not too late already).

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project.
