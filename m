From: rjw@sisk.pl (Rafael J. Wysocki)
Date: Tue, 26 Mar 2013 14:06:34 +0100
Subject: [PATCH 05/15] cpuidle: imx6: remove timer broadcast initialization
In-Reply-To: <51519A4E.4050501@linaro.org>
References: <1364234140-514-1-git-send-email-daniel.lezcano@linaro.org>
 <CAAQ0ZWQ-zex62SKNREK+fuRSg-djpu6dF-qN1Me+8ZEJ=E3F9w@mail.gmail.com>
 <51519A4E.4050501@linaro.org>
Message-ID: <3093827.CqqJZ0LU0r@vostro.rjw.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday, March 26, 2013 01:53:34 PM Daniel Lezcano wrote:
> On 03/26/2013 01:40 PM, Shawn Guo wrote:
> > On Tue, Mar 26, 2013 at 10:43:29AM +0100, Daniel Lezcano wrote:
> >> Hi Shawn,
> >>
> >> actually this is because the patch applies on top of:
> >>
> > Ah, ok. It will be helpful for people who want to test the series on
> > their platform, if you can publish a branch for that.
> 
> Yes, sure.
> 
> It is in Rafael's tree.
> 
> https://git.kernel.org/cgit/linux/kernel/git/rafael/linux-pm.git
> 
> in linux-next branch.

IOW, the patchset is based on the current linux-next. :-)

Thanks,
Rafael


> >> commit 12e849504b861470e5bf991f79c0be71b97c8dac
> >> Author: Daniel Lezcano <daniel.lezcano@linaro.org>
> >> Date:   Thu Mar 21 12:21:33 2013 +0000
> >>
> >>     cpuidle / imx6 : use CPUIDLE_FLAG_TIMER_STOP flag
> >>
> >>     Use the CPUIDLE_FLAG_TIMER_STOP and let the cpuidle framework
> >>     to handle the CLOCK_EVT_NOTIFY_BROADCAST_ENTER/EXIT when entering
> >>     this state.
> >>
> >>     Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> >>     Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> >>     Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> 
> 
-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
