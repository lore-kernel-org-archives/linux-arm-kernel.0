From: tbergstrom@nvidia.com (=?windows-1252?Q?Terje_Bergstr=F6m?=)
Date: Thu, 30 Oct 2014 13:04:02 +0200
Subject: [PATCH v4 05/12] memory: Add NVIDIA Tegra memory controller
 support
In-Reply-To: <54521181.8080005@nvidia.com>
References: <1413196434-5292-1-git-send-email-thierry.reding@gmail.com>
 <1413196434-5292-5-git-send-email-thierry.reding@gmail.com>
 <54520CFE.9060907@nvidia.com> <5452107D.8080207@nvidia.com>
 <54521181.8080005@nvidia.com>
Message-ID: <54521B22.6070708@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 30.10.2014 12:22, Alexandre Courbot wrote:
> So should I understand that the GPU group is for addresses without bit
> 34 set (hence forcibly disabled) while GPUB is used when that bit is
> set? Or is it something else?

That's exactly correct. And only GPUB can be programmed to be SMMU
translated.

Terje
