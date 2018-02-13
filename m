From: timur@codeaurora.org (Timur Tabi)
Date: Mon, 12 Feb 2018 18:10:38 -0600
Subject: [PATCH] arm64: Make L1_CACHE_SHIFT configurable
In-Reply-To: <ffc090d5-62c9-e608-32e2-8d13d01234e6@gmail.com>
References: <1518479125-14428-1-git-send-email-f.fainelli@gmail.com>
 <ca6c47f9-86df-bcdb-bbe1-eac9db68ec33@codeaurora.org>
 <ffc090d5-62c9-e608-32e2-8d13d01234e6@gmail.com>
Message-ID: <f5d6d768-d354-56b5-ce0c-4f46d4e6d642@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/12/2018 05:57 PM, Florian Fainelli wrote:
> That is debatable, is there a good publicly available table of what the
> typical L1 cache line size is on ARMv8 platforms?

I don't have that, but I was under the impression that we moved from 6 
to 7 because more and more ARMv8 platforms have 128-byte caches, so that 
is the "new normal".

-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm
Technologies, Inc.  Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
