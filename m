From: agross@codeaurora.org (Andy Gross)
Date: Mon, 12 Oct 2015 11:29:13 -0500
Subject: linux-next: manual merge of the qcom tree with the arm-soc tree
In-Reply-To: <20151012101912.33e77590@canb.auug.org.au>
References: <20151012101912.33e77590@canb.auug.org.au>
Message-ID: <20151012162913.GA31761@qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 12, 2015 at 10:19:12AM +1100, Stephen Rothwell wrote:
> Hi Andy,
> 
> Today's linux-next merge of the qcom tree got a conflict in:
> 
>   arch/arm/configs/multi_v7_defconfig
> 
> between commits:
> 
>   b605aded4491 ("ARM: multi_v7_defconfig: Add missing QCOM APQ8064 configs")
>   cc68819a582c ("ARM: multi_v7_defconfig: Enable Rockchip display support")
> 
> from the arm-soc tree and commit:
> 
>   4e7fb93081f8 ("ARM: multi_v7_defconfig: Enable QCOM SMD/RPM")
> 
> from the qcom tree.
> 
> I fixed it up (see below) and can carry the fix as necessary (no action


Thanks.  I'll redo that patch based on arm-soc's next before sending the pull
request.  multi_v7 defconfig changes are always a barrel o' fun

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
