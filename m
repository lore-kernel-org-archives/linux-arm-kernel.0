From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 8 Dec 2016 11:04:10 +0000
Subject: [Linaro-acpi] [PATCH v17 08/15]
 clocksource/drivers/arm_arch_timer: move arch_timer_needs_of_probing into DT
 init call
In-Reply-To: <CADyBb7vAfMGV5ERFqAbwo4v4BhJv5s_-x4DXmdvy=iUacBzJWQ@mail.gmail.com>
References: <20161125084623.22515-9-fu.wei@linaro.org>
 <201611252221.UyJ9iWPV%fengguang.wu@intel.com>
 <CADyBb7uAObQn_JVp_qw9+7POiqUctdzy3cYLsb0rk-JMX5W1uw@mail.gmail.com>
 <CAOZdJXU7Lg66RKvA=sYtUXUdwLLbh9FtcW0_U-fmjaztnqS3Ng@mail.gmail.com>
 <CADyBb7vAfMGV5ERFqAbwo4v4BhJv5s_-x4DXmdvy=iUacBzJWQ@mail.gmail.com>
Message-ID: <20161208110410.GA9768@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 08, 2016 at 11:16:21AM +0800, Fu Wei wrote:
> Hi Timur,
> 
> On 8 December 2016 at 01:25, Timur Tabi <timur@codeaurora.org> wrote:
> > On Fri, Nov 25, 2016 at 9:06 AM, Fu Wei <fu.wei@linaro.org> wrote:
> >>
> >> a "+ int ret;" should be move from [12/15] to here, I have fix the
> >> problem in my repo, it would happen in next patchset
> >>
> >> https://git.linaro.org/people/fu.wei/linux.git/log/?h=topic-gtdt-wakeup-timer_upstream_v18_devel
> >
> > Fu, please post v18 to the mailing list so that it can be picked up
> > for 4.10 (if it's not too late already).

Unfortunately, it's too late for v4.10. It hasn't been sat in linux-next
at all, and we've seen kbuild test failures.

Hopefully there's time to beat this into shape and get it into
linux-next so that it's ready to queue for v4.11, though.

> Great thanks for your suggestion!  :-)
> yes, you are right, I would love to post v18 ASAP.
> 
> But I am still waiting for more feedback from the maintainers.

Please post a version which passes inspection by the kbuild test robot.
I haven't had a chance to look at this yet, and it'll be better to look
at a version that actually works.

Thanks,
Mark.
