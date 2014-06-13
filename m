From: broonie@kernel.org (Mark Brown)
Date: Fri, 13 Jun 2014 18:05:11 +0100
Subject: [PATCH 3/3] ARM: dts: Enable audio support for Peach-pi board
In-Reply-To: <CAD=FV=XqqP7+xDOAKCixivzgaO0xvJX7L+CCN+unAEuf-6aUbQ@mail.gmail.com>
References: <1402464739-19044-1-git-send-email-tushar.b@samsung.com>
 <1402464739-19044-4-git-send-email-tushar.b@samsung.com>
 <CAD=FV=XqqP7+xDOAKCixivzgaO0xvJX7L+CCN+unAEuf-6aUbQ@mail.gmail.com>
Message-ID: <20140613170511.GA20112@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 13, 2014 at 10:03:50AM -0700, Doug Anderson wrote:
> On Tue, Jun 10, 2014 at 10:32 PM, Tushar Behera <tushar.b@samsung.com> wrote:

> > Peach-pi board has MAX98090 audio codec connected on HSI2C-7 bus.

> If you want to be a stickler about it, peach-pi actually has a
> max98091.  That requires code changes to the i2c driver, though.
> ...and unfortunately listing two compatible strings for i2c devices is
> broken.  :(

It is?  We should fix that if it's the case...
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140613/4f707c80/attachment.sig>
