From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 18 Nov 2014 13:31:22 -0800
Subject: [PATCH] ARM: vfp: Silence mvfr0 unused variable warning
In-Reply-To: <20141119081438.3df66238@canb.auug.org.au>
References: <1416344191-20484-1-git-send-email-sboyd@codeaurora.org>
 <20141119081438.3df66238@canb.auug.org.au>
Message-ID: <546BBAAA.4050909@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/18/2014 01:14 PM, Stephen Rothwell wrote:
> One small nit below:
>> +		if (IS_ENABLED(CONFIG_VFPv3)) {
>> +			mvfr0 = fmrx(MVFR0);
> Now that you have a block here, you could move the declaration of mvfr0
> into this block, right?
>

Sure I can squash in that change.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
