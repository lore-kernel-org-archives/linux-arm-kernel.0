From: pawel.moll@arm.com (Pawel Moll)
Date: Wed, 18 Apr 2012 15:31:24 +0100
Subject: [PATCH 7/7] MMC: mmci: Add required documentation for Device
 Tree bindings
In-Reply-To: <1334325909-5779-8-git-send-email-lee.jones@linaro.org>
References: <1334325909-5779-1-git-send-email-lee.jones@linaro.org>
 <1334325909-5779-8-git-send-email-lee.jones@linaro.org>
Message-ID: <1334759484.26922.11.camel@hornet>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2012-04-13 at 15:05 +0100, Lee Jones wrote:
> +Required properties:
> +- arm,primecell-periphid : contains the PrimeCell Peripheral ID.

I'd say that this is _very_ optional (as in: don't use this, unless you
know what are you doing ;-)

Also, how are you planning to represent the ".ocr_mask" part of the
platform data? (I'm asking about this particular one, because it's the
only I need on vexpress ;-)

Cheers!

Pawe?
