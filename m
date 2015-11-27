From: broonie@kernel.org (Mark Brown)
Date: Fri, 27 Nov 2015 11:05:27 +0000
Subject: [PATCH v3b] regulator: core: avoid unused variable warning
In-Reply-To: <6486349.NfasOOYIHJ@wuerfel>
References: <4083086.03MkICpY7S@wuerfel>
 <CAMuHMdWAR7D0LhehsH_cFi7pWM2awX+O8bD_aTboZymD6rreSA@mail.gmail.com>
 <6486349.NfasOOYIHJ@wuerfel>
Message-ID: <20151127110527.GK1929@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 27, 2015 at 10:36:35AM +0100, Arnd Bergmann wrote:
> On Friday 27 November 2015 10:25:11 Geert Uytterhoeven wrote:

> We could scrap that patch and take the other alternative that I sent
> (which is more obvious than this one), or add do it like this:
> 
> 8<---
> Subject: regulator: core: fix regulator_lock_supply regression

Please submit this normally, it looks OK.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151127/8e71439a/attachment.sig>
