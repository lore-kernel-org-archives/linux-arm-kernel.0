From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 30 May 2012 13:15:47 +0100
Subject: [PATCH 08/22] regulator: Change ab8500 match names to reflect
 Device Tree
In-Reply-To: <CAF2Aj3gZMF9ev9B46rBM+aY-srwthef09ad2CWfuXXFHmqqAjA@mail.gmail.com>
References: <1338353260-10097-1-git-send-email-lee.jones@linaro.org>
 <1338353260-10097-9-git-send-email-lee.jones@linaro.org>
 <CACRpkdbQv8Q07iRAmG3UQRm7UNDi_Y+s_vvACDKKxR9tg+1iqg@mail.gmail.com>
 <20120530100302.GD9947@opensource.wolfsonmicro.com>
 <CAF2Aj3gZMF9ev9B46rBM+aY-srwthef09ad2CWfuXXFHmqqAjA@mail.gmail.com>
Message-ID: <20120530121547.GJ9947@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 30, 2012 at 07:40:49PM +0800, Lee Jones wrote:
> On May 30, 2012 6:03 PM, "Mark Brown" <broonie@opensource.wolfsonmicro.com>

> > If we are changing the names then not including the ab8500 bit would
> > seem more idiomatic - we've already worked out which chip this is by the
> > time we're looking here.

> No, Linus had the wrong end of the stick. I've just spoken to him in person.

> Those are not the names of the regulators. They're the names of the Device
> Tree nodes. The regulator names shall remain the same.

Fair enough.  My point about the ab8500_ bit still stands though.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120530/b62cd32e/attachment.sig>
