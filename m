From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 14 Sep 2016 17:36:05 -0700
Subject: [PATCH 04/34] clk: bcm2835: Migrate to clk_hw based registration
 and OF APIs
In-Reply-To: <87r3cfa1n7.fsf@eliezer.anholt.net>
References: <20160601231533.9354-1-stephen.boyd@linaro.org>
 <20160601231533.9354-5-stephen.boyd@linaro.org>
 <87r3cfa1n7.fsf@eliezer.anholt.net>
Message-ID: <20160915003605.GJ7243@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/02, Eric Anholt wrote:
> Stephen Boyd <stephen.boyd@linaro.org> writes:
> 
> > Now that we have clk_hw based provider APIs to register clks, we
> > can get rid of struct clk pointers while registering clks in
> > these drivers, allowing us to move closer to a clear split of
> > consumer and provider clk APIs.
> 
> This looks good, but it'll conflict with the fixes for 4.7.  Could we
> land those first and then put this commit on top of that?

Done and merged to clk-next.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
