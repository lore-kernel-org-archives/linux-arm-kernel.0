From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 12 Feb 2014 12:08:25 -0700
Subject: [PATCH 1/2] ARM: tegra: enable I2C Mux driver for PCA9546 in
 defconfig
In-Reply-To: <1391817298-10600-1-git-send-email-pengw@nvidia.com>
References: <1391817298-10600-1-git-send-email-pengw@nvidia.com>
Message-ID: <52FBC6A9.7010401@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/07/2014 04:54 PM, Bryan Wu wrote:
> PCA9546 is used in Cardhu Tegra30 board to connect to 3 cameras.
> Enabling this driver for Tegra V4L2 soc camera driver and camera
> sensor drivers.

I've squashed patch 1/2 into Tegra's for-3.15/defconfig branch, and
applied patch 2/2 to Tegra's for-3.15/dt branch.

Note that your patches were sent with an email "From" address that
didn't match your signed-off-by tag, yet "git send-email" didn't insert
a "From" header in the email body. Can you please check your git user ID
and/or email settings. Consequently, I had to adjust the git author
field in git to match your s-o-b line.
