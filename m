From: bjorn.andersson@sonymobile.com (Bjorn Andersson)
Date: Tue, 14 Jul 2015 13:18:52 -0700
Subject: [PATCH v3] Input: pmic8xxx-pwrkey - Support shutdown
In-Reply-To: <1436900724-10994-1-git-send-email-sboyd@codeaurora.org>
References: <1436900724-10994-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <20150714201852.GB32767@usrtlx11787.corpusers.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue 14 Jul 12:05 PDT 2015, Stephen Boyd wrote:

> On pm8xxx PMICs, shutdown and restart are signaled to the PMIC
> via a pin called PS_HOLD. When this pin goes low, the PMIC
> performs a configurable power sequence. Add a .shutdown hook so
> that we can properly configure this power sequence for shutdown
> or restart depending on the system state.
> 
> Cc: Bjorn Andersson <bjorn.andersson@sonymobile.com>
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
> ---
> 
> Changes since v2:
>  * s/ret/error/
>  * Use of_device_get_match_data() and don't move match table
>  * Fix whitespace errors
> 

Reviewed-by: Bjorn Andersson <bjorn.andersson@sonymobile.com>

And thanks for finding of_device_get_match_data()

Regards,
Bjorn
