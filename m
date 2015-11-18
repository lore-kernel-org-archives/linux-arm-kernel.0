From: broonie@kernel.org (Mark Brown)
Date: Wed, 18 Nov 2015 17:52:09 +0000
Subject: [PATCH v3 3/3] ASoC: samsung: pass filter function as pointer
In-Reply-To: <5187956.iFJ0QGUy5T@wuerfel>
References: <11363089.F4JJ1Xsq7F@wuerfel>
 <5187956.iFJ0QGUy5T@wuerfel>
Message-ID: <20151118175209.GJ31303@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 18, 2015 at 03:26:41PM +0100, Arnd Bergmann wrote:
> As we are now passing the filter data as pointers to the drivers,
> we can take the final step and also pass the filter function the
> same way. I'm keeping this change separate, as there it's less
> obvious that this is a net win.

This doens't apply against current code, please check and resend.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151118/384bdbcf/attachment-0001.sig>
