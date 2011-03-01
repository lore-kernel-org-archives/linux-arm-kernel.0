From: davidb@codeaurora.org (David Brown)
Date: Tue, 01 Mar 2011 12:11:45 -0800
Subject: [RFC PATCH 5/5] RFC: msm: sps: Smart Peripheral System (SPS)
	driver.
In-Reply-To: <1298941892-25173-6-git-send-email-kheitke@codeaurora.org>
	(Kenneth Heitke's message of "Mon, 28 Feb 2011 18:11:32 -0700")
References: <1298941892-25173-1-git-send-email-kheitke@codeaurora.org>
	<1298941892-25173-6-git-send-email-kheitke@codeaurora.org>
Message-ID: <8yahbbmvbwe.fsf@huya.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 28 2011, Kenneth Heitke wrote:

> diff --git a/arch/arm/mach-msm/include/mach/msm_sps.h b/arch/arm/mach-msm/include/mach/msm_sps.h
> +

> diff --git a/arch/arm/mach-msm/sps/Makefile b/arch/arm/mach-msm/sps/Makefile
> +

> diff --git a/arch/arm/mach-msm/sps/sps.c b/arch/arm/mach-msm/sps/sps.c
> +

> diff --git a/arch/arm/mach-msm/sps/sps_bam.c b/arch/arm/mach-msm/sps/sps_bam.c
> +

These four files add spurious blank lines to the end of their files.  If
there are no other changes to the patches, I can fix this up before
applying the patches.  Otherwise, please remove these before resending
the patches.

Thanks,
David

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
