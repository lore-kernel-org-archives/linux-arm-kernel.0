From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 04 Jun 2013 10:00:27 -0600
Subject: [PATCH] clk: tegra114: Fix msenc clock register
In-Reply-To: <1370345143-4885-1-git-send-email-mperttunen@nvidia.com>
References: <1370345143-4885-1-git-send-email-mperttunen@nvidia.com>
Message-ID: <51AE0F1B.20602@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/04/2013 05:25 AM, Mikko Perttunen wrote:
> The msenc clock's register was set to the usb3 clock's register.

drivers/clk changes should be sent to Mike Turquette (CC'd here). See
the output of ./scripts/get_maintainer.pl and/or the MAINTAINERS file.

Hopefully he can pick this up from the ARM mailing list - if not, I'm
sure he'll let you know to resend it.
