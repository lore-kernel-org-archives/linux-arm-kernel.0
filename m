From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 6 Mar 2013 19:49:20 +0800
Subject: [PATCH] ASoC: samsung: let device core setup the default pin
 configuration
In-Reply-To: <201303061242.09978.heiko@sntech.de>
References: <1362570951-14403-1-git-send-email-thomas.abraham@linaro.org>
 <20130306113741.GA19556@opensource.wolfsonmicro.com>
 <201303061242.09978.heiko@sntech.de>
Message-ID: <20130306114918.GB19556@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 06, 2013 at 12:42:09PM +0100, Heiko St?bner wrote:

> What is going away is the deprecated non-pinctrl way to setup the pins on dt 
> platforms.

OK, can we have a changelog improvement please?  I didn't read the patch
properly because the changelog said it would break my primary
development system.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130306/d381082e/attachment.sig>
