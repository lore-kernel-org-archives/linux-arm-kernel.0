From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 14 Sep 2012 09:31:07 -0600
Subject: [PATCH] arm: tegra: dt: Add pinmux entries for Vbus regulator
 controls
In-Reply-To: <1347614754-26357-1-git-send-email-vbyravarasu@nvidia.com>
References: <1347614754-26357-1-git-send-email-vbyravarasu@nvidia.com>
Message-ID: <50534DBB.6010700@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/14/2012 03:25 AM, Venu Byravarasu wrote:
> Adding pinmux entries for PI4 and PH7 to enable Vbus for USB1
> and USB3 controllers on Cardhu A02 board.
> 
> Signed-off-by: Venu Byravarasu <vbyravarasu@nvidia.com>

Given our internal discussions about whether to and how to configure
open-drain and enable-input on these pins, I'd like to hold off on this
patch. Lets resolve this internally first.

Also, I assume we'll need an equivalent patch for Cardhu A04 too.
