From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 24 Sep 2014 11:34:02 -0700
Subject: [PATCH] ARM: qcom: Update SoC compatibles we support
In-Reply-To: <1411582838-24159-1-git-send-email-galak@codeaurora.org>
References: <1411582838-24159-1-git-send-email-galak@codeaurora.org>
Message-ID: <54230E9A.7020109@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/24/14 11:20, Kumar Gala wrote:
> Move to just using the SoC name in the compatible list so we don't need
> to update this for every board going forward.  Also added "qcom,msm8974"
> to the list as we support "qcom,apq8074" already (the modemless version
> of "qcom,msm8974").
>
> Signed-off-by: Kumar Gala <galak@codeaurora.org>
> ---

Or just remove the file entirely. Things work without having to add
anything here anyway.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
