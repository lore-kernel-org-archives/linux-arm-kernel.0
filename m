From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 14 Mar 2013 12:02:58 -0600
Subject: [PATCH 1/7] ARM: i.MX: Add GPT devicetree Documentation
In-Reply-To: <1363262942-26702-2-git-send-email-s.hauer@pengutronix.de>
References: <1363262942-26702-1-git-send-email-s.hauer@pengutronix.de>
 <1363262942-26702-2-git-send-email-s.hauer@pengutronix.de>
Message-ID: <514210D2.6010605@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/14/2013 06:08 AM, Sascha Hauer wrote:
> The GPT binding is already used on i.MX6 and i.MX25, but not yet
> documented. Add a binding document for it.

> diff --git a/Documentation/devicetree/bindings/timer/fsl,imxgpt.txt b/Documentation/devicetree/bindings/timer/fsl,imxgpt.txt

> +Freescale i.MX GPT

You might want to mention what "GPT" is here, or at least expand the
acronym. I first read this as "GUID Partition Table".
