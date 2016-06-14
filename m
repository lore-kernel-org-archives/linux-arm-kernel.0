From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 14 Jun 2016 12:48:53 -0700
Subject: [PATCH 3/5] ARM: dts: add L2CC and RPM with regulators for MSM8660
In-Reply-To: <20160614190217.GU1256@tuxbot>
References: <1465918259-11138-1-git-send-email-linus.walleij@linaro.org>
 <1465918259-11138-4-git-send-email-linus.walleij@linaro.org>
 <20160614185517.GG28218@codeaurora.org>
 <20160614190217.GU1256@tuxbot>
Message-ID: <20160614194853.GL28218@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/14, Bjorn Andersson wrote:
> On Tue 14 Jun 11:55 PDT 2016, Stephen Boyd wrote:
> 
> > On 06/14, Linus Walleij wrote:
> > > diff --git a/arch/arm/boot/dts/qcom-msm8660.dtsi b/arch/arm/boot/dts/qcom-msm8660.dtsi
> [..]
> > > +
> > > +			pm8901-regulators {
> > 
> > I'd rather have regulators at 8901 and regulators at 8058. That way the
> > node name is generic per ePAPR suggestions.
> > 
> 
> I agree, but unfortunately we're not allowed to do that without a
> matching "reg = <>" anymore.

Oh does dtc blow up now?

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
