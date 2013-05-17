From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 17 May 2013 17:57:38 -0600
Subject: [PATCH] ARM: tegra: Add charger subnode to tps65090 node
In-Reply-To: <1365623505-6309-1-git-send-email-rklein@nvidia.com>
References: <1365623505-6309-1-git-send-email-rklein@nvidia.com>
Message-ID: <5196C3F2.8070204@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/10/2013 01:51 PM, Rhyland Klein wrote:
> The charger is now represented by a distinct subnode of the tps65090
> device. Add this node and enable low current charging with it.

What's the status of the TPS60590 bindings; are they agreed upon by
NVIDIA, TI, and SlimLogic yet? In other words, is this patch still
something I should apply for 3.11, or does it need to be reworked?
