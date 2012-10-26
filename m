From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 25 Oct 2012 20:49:28 -0600
Subject: [PATCH] arm: bcm2835: remove useless variables from Makefile.boot
In-Reply-To: <1351166358-6134-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1351166358-6134-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <5089FA38.4040807@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/25/2012 05:59 AM, Thomas Petazzoni wrote:
> Neither params_phys-y nor initrd_phys-y are needed when booting with a
> Device Tree. Those values are passed through the Device Tree blob. So
> get rid of those variable definitions from Makefile.boot.

Thanks, applied to linux-rpi's for-3.8/cleanup branch.
