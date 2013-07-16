From: broonie@kernel.org (Mark Brown)
Date: Tue, 16 Jul 2013 16:57:40 +0100
Subject: [PATCH v3] rtc: Add MOXA ART RTC driver
In-Reply-To: <CACmBeS3jU2csACZCqXfRvCYAEHaK7S3AcJ++Yd=L-mgfeqg68A@mail.gmail.com>
References: <1373550711-18828-1-git-send-email-jonas.jensen@gmail.com>
 <1373978485-17496-1-git-send-email-jonas.jensen@gmail.com>
 <20130716131332.GL22506@sirena.org.uk>
 <CACmBeS3jU2csACZCqXfRvCYAEHaK7S3AcJ++Yd=L-mgfeqg68A@mail.gmail.com>
Message-ID: <20130716155740.GO22506@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 16, 2013 at 04:04:07PM +0200, Jonas Jensen wrote:
> On 16 July 2013 15:13, Mark Brown <broonie@kernel.org> wrote:
> > Since you're now using OF you should also be including a binding
> > document.

> The binding document already exist in set of patches adding MOXA ART
> SoC support ( I intend to mail out v4 once I know how to proceed ):

If that's the case then you need to point people at the binding document
when posting the driver but...

> Or should it be moved here to a new v4 patch?

...it's more normal to push the binding along with the driver.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130716/7e5b010a/attachment.sig>
