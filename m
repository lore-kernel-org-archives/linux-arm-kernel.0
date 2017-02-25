From: gregkh@linuxfoundation.org (Greg KH)
Date: Sat, 25 Feb 2017 09:04:54 +0100
Subject: [PATCH] arm64: dts: msm8996: Add modem and slpi smp2p nodes
In-Reply-To: <20170224162605.31290-1-bjorn.andersson@linaro.org>
References: <20170224162605.31290-1-bjorn.andersson@linaro.org>
Message-ID: <20170225080454.GB2291@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 24, 2017 at 08:26:05AM -0800, Bjorn Andersson wrote:
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/msm8996.dtsi | 48 +++++++++++++++++++++++++++++++++++
>  1 file changed, 48 insertions(+)

I personally reject any patch with no changelog text, so I wouldn't get
used to doing that if you want other maintainers to take your
patches...
