From: agross@codeaurora.org (Andy Gross)
Date: Wed, 26 Aug 2015 23:36:54 -0500
Subject: [PATCH 06/10] ARM: dts: qcom: apq8084-mtp: Use stdout-path
In-Reply-To: <1434490313-13905-7-git-send-email-sboyd@codeaurora.org>
References: <1434490313-13905-1-git-send-email-sboyd@codeaurora.org>
 <1434490313-13905-7-git-send-email-sboyd@codeaurora.org>
Message-ID: <20150827043654.GJ28274@qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 16, 2015 at 02:31:49PM -0700, Stephen Boyd wrote:
> Use stdout-path so that we don't have to put the console on the
> kernel command line.
> 
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
> ---
>  arch/arm/boot/dts/qcom-apq8084-mtp.dts | 8 ++++++++
>  1 file changed, 8 insertions(+)


Applied.  Thanks

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
