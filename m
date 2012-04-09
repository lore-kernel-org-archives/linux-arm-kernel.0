From: viresh.kumar@st.com (Viresh Kumar)
Date: Mon, 9 Apr 2012 09:01:03 +0530
Subject: [PATCH 1/1] pinctrl: fix pinmux_check_ops error checking
In-Reply-To: <4F7F0C7E.6030407@wwwdotorg.org>
References: <1333714689-22450-1-git-send-email-b29396@freescale.com>
 <4F7F0C7E.6030407@wwwdotorg.org>
Message-ID: <4F8257F7.60302@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4/6/2012 9:02 PM, Stephen Warren wrote:
> On 04/06/2012 06:18 AM, Dong Aisheng wrote:
>> > From: Dong Aisheng <dong.aisheng@linaro.org>
>> > 
>> > Do not use get_functions_count before checking.
>> > 
>> > Signed-off-by: Dong Aisheng <dong.aisheng@linaro.org>
> Acked-by: Stephen Warren <swarren@wwwdotorg.org>
> 
> IIRC, Viresh added some other get_*_count() functions in the same patch.
> Do we need any more fixes similar to the this for those too?

Might not be required as this patch handles the pinmux_check_ops() routine.
At other places ops is guaranteed to have correct value.

-- 
viresh
