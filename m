From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon, 10 Feb 2014 22:35:46 -0800
Subject: [PATCH v3 0/7] Modernize pm8921 with irqdomains, regmap, DT
In-Reply-To: <1389206270-3728-1-git-send-email-sboyd@codeaurora.org>
References: <1389206270-3728-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <20140211063546.GF10784@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/08, Stephen Boyd wrote:
> These patches lay the groundwork for converting the pm8921 sub-devices
> to devicetree as well as simplify the API by migrating the core code
> to use the regmap API instead of the custom pm8xxx read/write wrapper.

Lee,

Can you pick up these patches now? I don't think we're going to
get an ack from the DT reviewers. Its been over a month and
according to the documentation[1] I think we've done our due
diligence.

[1] Documentation/devicetree/bindings/submitting-patches.txt

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
