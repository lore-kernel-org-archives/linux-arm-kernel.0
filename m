From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 20 Nov 2015 09:53:34 -0800
Subject: [RFC/PATCH] pinctrl: qcom: Add generic ssbi and spmi GPIO/MPP
 bindings
In-Reply-To: <20151119145017.GA19795@rob-hp-laptop>
References: <1447808426-21834-1-git-send-email-sboyd@codeaurora.org>
 <20151119145017.GA19795@rob-hp-laptop>
Message-ID: <20151120175334.GR32672@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/19, Rob Herring wrote:
> On Tue, Nov 17, 2015 at 05:00:26PM -0800, Stephen Boyd wrote:
> > The drivers don't really need to know which PMIC they're for, so
> > make a generic binding for them. This alleviates us from updating
> > the drivers every time a new PMIC comes out. It's still
> > recommended that we update the binding with new PMIC models and
> > always specify the specific model for the MPPs and gpios before
> > the generic compatible string in devicetree, but this at least
> > cuts down on adding more and more compatible strings to the
> > drivers until we actually need them.
> > 
> > Cc: <devicetree@vger.kernel.org>
> > Cc: "Ivan T. Ivanov" <iivanov@mm-sol.com>
> > Cc: Bjorn Andersson <bjorn.andersson@sonymobile.com>
> > Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
> > ---
> 
> Seems okay to me. I assume you are going to update all the dts files?

Yep, I'll send out patches to do that.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
