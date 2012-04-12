From: richardcochran@gmail.com (Richard Cochran)
Date: Thu, 12 Apr 2012 07:25:20 +0200
Subject: [PATCH 1/2] ARM: ixp4xx: fix compilation, add gpiolib support
In-Reply-To: <1328729069-21308-2-git-send-email-mkl@blackshift.org>
References: <1328729069-21308-1-git-send-email-mkl@blackshift.org>
 <1328729069-21308-2-git-send-email-mkl@blackshift.org>
Message-ID: <20120412052518.GA3260@netboy.at.omicron.at>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 08, 2012 at 08:24:28PM +0100, Marc Kleine-Budde wrote:
> From: Imre Kaloz <kaloz@openwrt.org>
> 
> The problem was introduced with commit:
> "eb9ae7f gpio: fix build error in include/asm-generic/gpio.h"
> 
> This patch adds gpiolib support for the IXP4xx platform, which fixes the
> compilation of several ixp4xx platforms, e.g.:

Sorry to nag, but is someone going to take this patch?

Thanks,
Richard
