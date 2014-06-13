From: broonie@kernel.org (Mark Brown)
Date: Fri, 13 Jun 2014 23:04:21 +0100
Subject: [PATCH 3/3] ARM: dts: Enable audio support for Peach-pi board
In-Reply-To: <CAD=FV=XCk9E-7VPV=LQrdLU5fKsFHviQf79MBmC8va3gsg=Ydw@mail.gmail.com>
References: <1402464739-19044-1-git-send-email-tushar.b@samsung.com>
 <1402464739-19044-4-git-send-email-tushar.b@samsung.com>
 <CAD=FV=XqqP7+xDOAKCixivzgaO0xvJX7L+CCN+unAEuf-6aUbQ@mail.gmail.com>
 <20140613170511.GA20112@sirena.org.uk>
 <CAD=FV=VvkvH1TPiKttm9VXbBRnBo7kmTVK8bZZvexK=bAvaO4Q@mail.gmail.com>
 <CAD=FV=XCk9E-7VPV=LQrdLU5fKsFHviQf79MBmC8va3gsg=Ydw@mail.gmail.com>
Message-ID: <20140613220421.GD5099@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 13, 2014 at 02:58:26PM -0700, Doug Anderson wrote:

> Anyway, suffice to say that the i2c core needs to be extended to
> handle the idea that a single device has more than one "compatible"
> string.  I'll leave it to an eager reader of this thread to implement
> this since we can also fix our own problem by just listing "max98091"
> in "sound/soc/codecs/max98090.c" like has always been done in the
> past.

Why do you need to register multiple compatible strings (I guess for
fallback purposes?).  A quick fix that is about as good is to take the
first compatible only.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140613/49590638/attachment.sig>
