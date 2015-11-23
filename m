From: iivanov.xz@gmail.com (Ivan T. Ivanov)
Date: Mon, 23 Nov 2015 08:37:19 +0200
Subject: [RFC/PATCH] pinctrl: qcom: Add generic ssbi and spmi GPIO/MPP
 bindings
In-Reply-To: <1447808426-21834-1-git-send-email-sboyd@codeaurora.org>
References: <1447808426-21834-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <30F64119-A5B2-45FA-ABA2-A7FB1A1D7952@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> On Nov 18, 2015, at 3:00 AM, Stephen Boyd <sboyd@codeaurora.org> wrote:
> 
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

Thanks.

Acked-by: Ivan T. Ivanov <iivanov.xz@gmail.com>
