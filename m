From: okaya@codeaurora.org (Sinan Kaya)
Date: Thu, 10 Mar 2016 12:00:13 -0500
Subject: [PATCH 1/2] vfio, platform: add support for ACPI while detecting
 the reset driver
In-Reply-To: <20160310075830.GB5273@mwanda>
References: <1457451209-21462-1-git-send-email-okaya@codeaurora.org>
 <56DEF1BE.8010701@codeaurora.org> <20160310075830.GB5273@mwanda>
Message-ID: <56E1A81D.7020207@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 3/10/2016 2:58 AM, Dan Carpenter wrote:
> -1 is a magic number which stands for -EPERM which is wrong.  Use
> -ENODEV.

OK. done.

-- 
Sinan Kaya
Qualcomm Technologies, Inc. on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project
