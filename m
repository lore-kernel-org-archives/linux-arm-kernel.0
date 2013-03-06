From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 6 Mar 2013 19:37:43 +0800
Subject: [PATCH] ASoC: samsung: let device core setup the default pin
 configuration
In-Reply-To: <1362570951-14403-1-git-send-email-thomas.abraham@linaro.org>
References: <1362570951-14403-1-git-send-email-thomas.abraham@linaro.org>
Message-ID: <20130306113741.GA19556@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 06, 2013 at 05:25:51PM +0530, Thomas Abraham wrote:

> With device core now able to setup the default pin configuration,
> the pin configuration code based on the deprecated Samsung specific
> gpio bindings in i2s driver is removed.

There's rather a lot of non-DT Samsung platforms...
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130306/34705c92/attachment.sig>
