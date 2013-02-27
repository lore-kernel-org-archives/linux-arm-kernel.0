From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 27 Feb 2013 11:58:33 -0700
Subject: [PATCH V2 4/4] ARM: tegra114: bring up secondary CPU for SMP
In-Reply-To: <1361932087-13372-5-git-send-email-josephl@nvidia.com>
References: <1361932087-13372-1-git-send-email-josephl@nvidia.com>
 <1361932087-13372-5-git-send-email-josephl@nvidia.com>
Message-ID: <512E5759.70605@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/26/2013 07:28 PM, Joseph Lo wrote:
> The secondary CPU can be brought up by toggling the power in PMC. Then
> the flow controller will release CPU to go by clearing the reset and
> clamp signal automatically.

Patches 3 and 4 look fine as-is.
