From: broonie@kernel.org (Mark Brown)
Date: Wed, 30 Apr 2014 18:31:03 -0700
Subject: [alsa-devel] [PATCH 01/15] ASoC: CS42L51 and WM8962 codecs
 depend on INPUT
In-Reply-To: <alpine.DEB.2.02.1404292124270.31465@heelrod>
References: <1398770316-19715-1-git-send-email-kaixu.xia@linaro.org>
 <1398770316-19715-2-git-send-email-kaixu.xia@linaro.org>
 <alpine.DEB.2.02.1404292124270.31465@heelrod>
Message-ID: <20140501013103.GK3245@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 29, 2014 at 09:31:30PM -0500, Brian Austin wrote:

> I assume you mean the CS42L52 instead of the L51. INPUT is used for a BEEP
> Generator but when I disable CONFIG_INPUT I do not get an error. Is there
> any information available on what the error is?

I suspect it's ASoC built in and INPUT build as a module.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140430/5fc142ba/attachment.sig>
