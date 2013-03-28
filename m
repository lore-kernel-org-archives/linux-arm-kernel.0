From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 28 Mar 2013 12:41:44 -0600
Subject: [PATCH] ARM: tegra: add clocks property to AC'97 sound nodes
In-Reply-To: <1364494718-12098-1-git-send-email-swarren@wwwdotorg.org>
References: <1364494718-12098-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <51548EE8.5040704@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/28/2013 12:18 PM, Stephen Warren wrote:
> From: Stephen Warren <swarren@nvidia.com>
> 
> Audio-related clocks need to be represented in the device tree. Update
> bindings to describe which clocks are needed, and DT files to include
> those clocks.

Applied to Tegra's for-3.10/dt branch.
