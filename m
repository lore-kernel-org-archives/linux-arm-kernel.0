From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 26 Mar 2012 18:43:30 +0100
Subject: [GIT PULL] pxa io.h clean-up fixes
In-Reply-To: <4F6FC82C.2040303@gmail.com>
References: <4F6FC82C.2040303@gmail.com>
Message-ID: <20120326174330.GI3789@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Mar 25, 2012 at 08:36:44PM -0500, Rob Herring wrote:

> There's some new breakage when I merged the current next in and built
> with Russell's pxa test config. The failures are due to struct device
> removal in this commit:

Paul Gortmaker did send some attempts at fixing these, I don't know if
they ever got applied though.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120326/5c284a36/attachment.sig>
