From: agross@codeaurora.org (Andy Gross)
Date: Wed, 26 Aug 2015 23:17:28 -0500
Subject: [PATCH 04/10] ARM: dts: qcom: apq8074-dragonboard: Use stdout-path
In-Reply-To: <1434490313-13905-5-git-send-email-sboyd@codeaurora.org>
References: <1434490313-13905-1-git-send-email-sboyd@codeaurora.org>
 <1434490313-13905-5-git-send-email-sboyd@codeaurora.org>
Message-ID: <20150827041728.GB28274@qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 16, 2015 at 02:31:47PM -0700, Stephen Boyd wrote:
> Use stdout-path so that we don't have to put the console on the
> kernel command line.
> 
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
> ---
>  arch/arm/boot/dts/qcom-apq8074-dragonboard.dts | 8 ++++++++
>  1 file changed, 8 insertions(+)

Thanks.  Applied.

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
