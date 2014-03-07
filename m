From: wsa@the-dreams.de (Wolfram Sang)
Date: Fri, 7 Mar 2014 11:37:30 +0100
Subject: [PATCH v3 1/5] i2c: mv64xxx: Add reset deassert call
In-Reply-To: <20140307103433.GH21483@n2100.arm.linux.org.uk>
References: <1393950521-4173-1-git-send-email-maxime.ripard@free-electrons.com>
 <1393950521-4173-2-git-send-email-maxime.ripard@free-electrons.com>
 <20140307095222.GG21483@n2100.arm.linux.org.uk>
 <20140307100751.GN607@lukather>
 <20140307103433.GH21483@n2100.arm.linux.org.uk>
Message-ID: <20140307103730.GA12274@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> Since RESET_CONTROLLER is not required for those platforms, it really
> should be optional - and I think the real fix is for the reset controller
> support to provide stub functions.

I agree; and I assumed it already does. Will resend a patch posted
earlier [1] to fix the issue. And still debugging why my build-tests
didn't get it :(

[1] https://lkml.org/lkml/2013/8/9/442

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140307/42c8ccff/attachment.sig>
