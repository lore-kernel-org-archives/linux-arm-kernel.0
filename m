From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 02 Jan 2013 12:46:08 -0700
Subject: [PATCH 1/2] ARM: tegra: trimslice: add gpio-poweroff node to
 DT
In-Reply-To: <1357152377-5918-1-git-send-email-swarren@wwwdotorg.org>
References: <1357152377-5918-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <50E48E80.20800@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/02/2013 11:46 AM, Stephen Warren wrote:
> From: Stephen Warren <swarren@nvidia.com>
> 
> ... and disable tri-state from the pingroup that contains the poweroff
> GPIO.

Applied to Tegra's for-3.9/dt branch.
