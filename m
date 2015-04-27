From: broonie@kernel.org (Mark Brown)
Date: Mon, 27 Apr 2015 21:57:42 +0100
Subject: Question about DC-DC frequency handling
In-Reply-To: <68391817.574800.1430167496498.JavaMail.open-xchange@oxbaltgw01.schlund.de>
References: <604104768.496325.1430058690855.JavaMail.open-xchange@oxbaltgw00.schlund.de>
 <20150426190729.16410.58019@quantum>
 <68391817.574800.1430167496498.JavaMail.open-xchange@oxbaltgw01.schlund.de>
Message-ID: <20150427205742.GN22845@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 27, 2015 at 10:44:56PM +0200, Stefan Wahren wrote:
> > Michael Turquette <mturquette@linaro.org> hat am 26. April 2015 um 21:07
> > Quoting Stefan Wahren (2015-04-26 07:31:30)

> > I'll hazard a guess that they do not care. DC-DC switching frequency is
> > an important aspect of power supply design, but switching frequency of a
> > power supply is not controlled by the clock framework in any example
> > that I am aware of.

> yes the consumers don't care. My intension for changing the switching frequency
> is
> to avoid interferences on HF band.

You may also find that the switching frequency is dictated by the choice
of passives on the board - you may find there's restrictions there that
mean the user can't freely choose without running into performance
problems.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150427/fd70eb97/attachment-0001.sig>
