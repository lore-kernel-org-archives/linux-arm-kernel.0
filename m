From: mturquette@ti.com (Turquette, Mike)
Date: Fri, 13 Apr 2012 15:23:16 -0700
Subject: [PATCH 01/13] clk: core: correct clk_set_rate kerneldoc
In-Reply-To: <4F8659DA.4030305@st.com>
References: <1334192572-12499-1-git-send-email-mturquette@linaro.org>
 <1334192572-12499-2-git-send-email-mturquette@linaro.org>
 <4F8659DA.4030305@st.com>
Message-ID: <CAJOA=zMHGO6N2q=StogU3envVBt23o-2Od70gtdRkQG_Ku7=CA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 11, 2012 at 9:28 PM, Viresh Kumar <viresh.kumar@st.com> wrote:
> On 4/12/2012 6:32 AM, Mike Turquette wrote:
>> - * If clk has the CLK_SET_RATE_GATE flag set and it is enabled this call
>> - * will fail; only when the clk is disabled will it be able to change
>> - * its rate.
>
> Why is CLK_SET_RATE_GATE removed? I already sent a patch to fix clk_set_rate()
> for this. And i think it should be required.

I removed it from the documentation since it was not present in the
code.  I was originally targeting this for an -rc and I was trying to
limit the changes purely to fixes and cleanups, not new features.

I haven't finished digging through all of the responses yet, so my
goal for where these patches are headed might change.

Regards,
Mike
