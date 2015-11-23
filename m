From: bjorn.andersson@sonymobile.com (Bjorn Andersson)
Date: Mon, 23 Nov 2015 10:22:57 -0800
Subject: [RFC/PATCH] pinctrl: qcom: Add generic ssbi and spmi GPIO/MPP
 bindings
In-Reply-To: <1447808426-21834-1-git-send-email-sboyd@codeaurora.org>
References: <1447808426-21834-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <20151123182257.GP30882@usrtlx11787.corpusers.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue 17 Nov 17:00 PST 2015, Stephen Boyd wrote:

> The drivers don't really need to know which PMIC they're for, so
> make a generic binding for them. This alleviates us from updating
> the drivers every time a new PMIC comes out. It's still
> recommended that we update the binding with new PMIC models and
> always specify the specific model for the MPPs and gpios before
> the generic compatible string in devicetree, but this at least
> cuts down on adding more and more compatible strings to the
> drivers until we actually need them.
> 
> Cc: <devicetree@vger.kernel.org>
> Cc: "Ivan T. Ivanov" <iivanov@mm-sol.com>
> Cc: Bjorn Andersson <bjorn.andersson@sonymobile.com>
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
> ---
> 

I must say that when it comes to writing dts files I much prefer the msm
way of denoting functions over the pmic one. But because of that
decision this makes perfect sense!

Reviewed-by: Bjorn Andersson <bjorn.andersson@sonymobile.com>

Regards,
Bjorn
