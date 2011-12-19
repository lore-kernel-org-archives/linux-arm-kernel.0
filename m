From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon, 19 Dec 2011 09:42:29 -0800
Subject: [PATCH V2 1/4] cpufreq: add arm soc generic cpufreq driver
In-Reply-To: <20111219010357.GW28768@b20223-02.ap.freescale.net>
References: <1324031462-24961-1-git-send-email-richard.zhao@linaro.org>
 <1324031462-24961-2-git-send-email-richard.zhao@linaro.org>
 <20111216105229.GB3230@totoro> <4EEBA306.3060309@codeaurora.org>
 <20111219010357.GW28768@b20223-02.ap.freescale.net>
Message-ID: <4EEF7785.8040907@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/18/11 17:03, Richard Zhao wrote:
>
> Do you have to patch to implement per-cpu udelay? In current code, udelay uses
> global loops_per_jiffy.
>
>

We've been carrying forward the timer based udelay patches. They're in
the patch tracker as 6873/1, 6874/1, and 6875/1.

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
