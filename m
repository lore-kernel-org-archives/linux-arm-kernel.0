From: broonie@kernel.org (Mark Brown)
Date: Tue, 11 Nov 2014 13:23:09 +0000
Subject: [PATCH 02/15] GPIO: port LoCoMo gpio support from old driver
In-Reply-To: <CALT56yPr42FV66USngocw=eWPt81d5R2MJxmzBnv02HOMmXAkA@mail.gmail.com>
References: <1414454528-24240-1-git-send-email-dbaryshkov@gmail.com>
 <1414454528-24240-3-git-send-email-dbaryshkov@gmail.com>
 <CACRpkdY7tRadod2vQfEytmw-ubaMAvr_=XTczD5bUMkqie0xkg@mail.gmail.com>
 <CALT56yOgMUA7o2dzfHph=S2zkDV4zERzMh4ishpPwpAx7Cqj6Q@mail.gmail.com>
 <CACRpkdb7v3LmOhbhQ9TPk1_bnLnpwizawW6RQvhQRLSjRewAaQ@mail.gmail.com>
 <CALT56yO9f8wzaArnmfQSDzCM3S+2oT+62anH5kbFY3WdEt_HZg@mail.gmail.com>
 <20141106060335.GR8509@sirena.org.uk>
 <CALT56yPr42FV66USngocw=eWPt81d5R2MJxmzBnv02HOMmXAkA@mail.gmail.com>
Message-ID: <20141111132309.GX3815@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 11, 2014 at 05:16:38PM +0400, Dmitry Eremin-Solenikov wrote:

> Just to better understand your suggestions: do you want me to convert
> to regmap only gpio driver or do you suggest to convert all LoCoMo drivers?
> That is doable, of course, but the amount of changes is overwhelming.
> Also I'm concerned about the performance impact from going through
> regmap layers.

I don't care.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141111/6685a490/attachment-0001.sig>
