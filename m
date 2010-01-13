From: arhuaco@freaks-unidos.net (Nelson Castillo)
Date: Wed, 13 Jan 2010 09:39:11 -0500
Subject: [PATCH] S3C: Remove unneeded __init symbols
In-Reply-To: <20100109210339.GB10587@pengutronix.de>
References: <20100109100430.5258.8254.stgit@localhost>
	<20100109210339.GB10587@pengutronix.de>
Message-ID: <2accc2ff1001130639p2d33e95aj3d0730964c074bdf@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2010/1/9 Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>:
> Hi Nelson,
>
> On Sat, Jan 09, 2010 at 05:04:30AM -0500, Nelson Castillo wrote:
>> Two functions defined with __init are also exported.
>> Let's remove the __init symbols in order to avoid two warnings.
> Can you quote the warnings please?

Done. Patch attached.

> And I thought you agreed that "unneeded" for __init isn't optimal.

I also changed the subject. I don't know if it's optimal but it's
better now IMHO :-P
-------------- next part --------------
A non-text attachment was scrubbed...
Name: s3c-remove-unneeded-init-annotations.patch
Type: text/x-diff
Size: 2176 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100113/c54a46ba/attachment.bin>
