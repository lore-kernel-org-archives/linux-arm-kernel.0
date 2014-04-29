From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 29 Apr 2014 10:15:08 -0600
Subject: [PATCH] ARM: tegra: add SD wp-gpios to Jetson TK1 DT
In-Reply-To: <1398704846-18262-1-git-send-email-swarren@wwwdotorg.org>
References: <1398704846-18262-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <535FD00C.7090300@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/28/2014 11:07 AM, Stephen Warren wrote:
> Jetson TK1 can detect write-protect on the SD card. Add the required
> DT entries to allow this.

Applied to Tegra's for-3.16/dt branch.
