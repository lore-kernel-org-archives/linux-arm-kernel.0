From: bjorn.andersson@linaro.org (Bjorn Andersson)
Date: Mon, 5 Sep 2016 21:26:17 -0700
Subject: [PATCH 1/2 v6] bus: qcom: add EBI2 device tree bindings
In-Reply-To: <1473112255-7790-1-git-send-email-linus.walleij@linaro.org>
References: <1473112255-7790-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <20160906042617.GA15161@tuxbot>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon 05 Sep 14:50 PDT 2016, Linus Walleij wrote:

> diff --git a/Documentation/devicetree/bindings/bus/qcom,ebi2.txt b/Documentation/devicetree/bindings/bus/qcom,ebi2.txt
[..]
> +Also CS1 and CS2 has -A and -B signals. Why they have that is unclear to me.
> +

Most Qualcomm platforms has a few functions that has a second level of
muxing, probably as a solution to pin collisions or some other hardware
constraints.

It looks like this is what you're seeing.

Regards,
Bjorn
