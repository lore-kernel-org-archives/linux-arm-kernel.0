From: broonie@kernel.org (Mark Brown)
Date: Wed, 28 Aug 2013 10:53:15 +0100
Subject: [PATCH 09/18] ASoC: Samsung: Do not queue cyclic buffers
 multiple times
In-Reply-To: <CACRpkdZd+LJeZdSjsD6OCLOnZ0VrDg0aa-e163NXsw6ajWf7rA@mail.gmail.com>
References: <1376243970-6489-1-git-send-email-tomasz.figa@gmail.com>
 <1376243970-6489-10-git-send-email-tomasz.figa@gmail.com>
 <CACRpkdZd+LJeZdSjsD6OCLOnZ0VrDg0aa-e163NXsw6ajWf7rA@mail.gmail.com>
Message-ID: <20130828095315.GG10783@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 28, 2013 at 09:06:27AM +0200, Linus Walleij wrote:

> If patch 1 thru 9 are uncontroversial now, maybe Vinod can apply
> these for v3.12 so we can get less noise and risk of collissions
> in the next merge window?

Patch 9 I was going to apply to ASoC towards the end of the release
cycle - it shouldn't depend on the earlier ones as ASoC isn't using
dmaengine yet.  Holding off partly to run testing and partly in case
this ends up getting applied.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130828/57b4d1a1/attachment.sig>
