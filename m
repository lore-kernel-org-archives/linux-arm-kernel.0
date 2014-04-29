From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 29 Apr 2014 10:15:17 -0600
Subject: [PATCH] ARM: tegra: add SD wp-gpios to Dalmore DT
In-Reply-To: <1398711106-22484-1-git-send-email-swarren@wwwdotorg.org>
References: <1398711106-22484-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <535FD015.80602@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/28/2014 12:51 PM, Stephen Warren wrote:
> Dalmore can detect write-protect on the SD card. Add the required
> DT entries to allow this.

Applied to Tegra's for-3.16/dt branch.
