From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 26 Mar 2013 14:38:05 -0600
Subject: [PATCH 1/2] ARM: tegra: use setup_mm_for_reboot rather than
 explicit pgd switch
In-Reply-To: <1364235552-17851-1-git-send-email-will.deacon@arm.com>
References: <1364235552-17851-1-git-send-email-will.deacon@arm.com>
Message-ID: <5152072D.6020201@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/25/2013 12:19 PM, Will Deacon wrote:
> This patch changes the Tegra PM code to use the setup_mm_for_reboot
> helper rather than call cpu_switch_mm directly. This keeps things like
> TLB invalidation in one place.

I've applied this to Tegra's for-3.10/cleanup branch.
