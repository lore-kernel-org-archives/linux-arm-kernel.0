From: eric@anholt.net (Eric Anholt)
Date: Wed, 19 Jul 2017 12:50:29 -0700
Subject: [PATCH] pinctrl: Convert to using %pOF instead of full_name
In-Reply-To: <20170718214339.7774-43-robh@kernel.org>
References: <20170718214339.7774-43-robh@kernel.org>
Message-ID: <87r2xcdx4q.fsf@eliezer.anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Rob Herring <robh@kernel.org> writes:

> Now that we have a custom printf format specifier, convert users of
> full_name to use %pOF instead. This is preparation to remove storing
> of the full path string for each node.

For bcm283x:

Acked-by: Eric Anholt <eric@anholt.net>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 832 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170719/d478e68a/attachment.sig>
