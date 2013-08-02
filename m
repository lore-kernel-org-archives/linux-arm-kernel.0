From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 01 Aug 2013 20:29:27 -0600
Subject: [RESEND PATCH 1/2] ARM: msm: Add support for MSM8974
In-Reply-To: <1375406619-14618-1-git-send-email-rvaswani@codeaurora.org>
References: <1375406619-14618-1-git-send-email-rvaswani@codeaurora.org>
Message-ID: <51FB1987.3060806@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/01/2013 07:23 PM, Rohit Vaswani wrote:
> This patch adds basic board support for MSM8974 which
> belongs to the Snapdragon 800 family.
> For now, just support a basic machine with device tree.

>  arch/arm/boot/dts/msm8974.dts     | 26 ++++++++++++++++++++++++++

That's odd. If this is support for an SoC, why not a *.dtsi file rather
than *.dts?
