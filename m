From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 1 Dec 2015 20:42:10 -0700
Subject: [PATCH RFC 2/4] ARM: bcm2835: rename sdhci pin group
In-Reply-To: <1447949176-21926-3-git-send-email-stefan.wahren@i2se.com>
References: <1447949176-21926-1-git-send-email-stefan.wahren@i2se.com>
 <1447949176-21926-3-git-send-email-stefan.wahren@i2se.com>
Message-ID: <565E6892.4070600@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/19/2015 09:06 AM, Stefan Wahren wrote:
> The node name of the sdhci pin group doesn't explain it's
> real function. So rename it.

The real function of this node is not to configure SDHCI pins, but to
set pins to alt3, as the current name states. Admittedly it's possible
that currently the only pins that need to be set to ALT3 are SDHCI
related, but that's incidental.
