From: okaya@codeaurora.org (Sinan Kaya)
Date: Fri, 18 May 2018 10:20:29 -0400
Subject: [PATCH] efi/fb: Convert PCI bus address to resource if translated
 by the bridge
In-Reply-To: <36cf3f12-bfe8-1c38-4d2c-b785fc64a3f6@arm.com>
References: <1526563343-28721-1-git-send-email-okaya@codeaurora.org>
 <36cf3f12-bfe8-1c38-4d2c-b785fc64a3f6@arm.com>
Message-ID: <733101d0-9051-a5a6-ef64-162d8d1e10a1@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 5/18/2018 6:42 AM, Robin Murphy wrote:
> 
> FWIW, now that I've actually gone and looked, it appears you could simplify the whole function quite a bit by getting rid of these and just using the new local resource directly, especially since the only actual use of size is an open-coded resource_contains().

Posted V2 a minute ago. I did the simplification on a prior patch in order not to
mix the issues.

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
