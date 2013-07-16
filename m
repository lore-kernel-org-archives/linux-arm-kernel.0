From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 16 Jul 2013 10:21:31 -0600
Subject: [PATCH] ARM: tegra: remove tegra114-pluto.dts
In-Reply-To: <1373914547-6075-1-git-send-email-swarren@wwwdotorg.org>
References: <1373914547-6075-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <51E5730B.50705@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/15/2013 12:55 PM, Stephen Warren wrote:
> Early upstream work on Tegra114 was performed on the Pluto board.
> However, it's not used any more, and the DT doesn't contain anything
> beyond a serial port, so the file isn't useful either. Remove it.

Applied to Tegra's for-3.12/dt branch.
