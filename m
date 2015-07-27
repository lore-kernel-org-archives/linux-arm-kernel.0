From: agross@codeaurora.org (Andy Gross)
Date: Mon, 27 Jul 2015 15:55:12 -0500
Subject: [PATCH v1 7/7] ARM: dts: apq8064: fix missing gsbi cell-index
In-Reply-To: <1438005139-16562-1-git-send-email-srinivas.kandagatla@linaro.org>
References: <1438004945-16175-1-git-send-email-srinivas.kandagatla@linaro.org>
 <1438005139-16562-1-git-send-email-srinivas.kandagatla@linaro.org>
Message-ID: <20150727205512.GF12739@qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 27, 2015 at 02:52:19PM +0100, Srinivas Kandagatla wrote:
> Without this i2c instance for missing cell-index nodes would fail, fix
> it by adding correct cell-index.
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---

Applied.  Thanks.

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
