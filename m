From: broonie@kernel.org (Mark Brown)
Date: Mon, 13 Jan 2014 12:17:26 +0000
Subject: [PATCH RFC 06/10] ARM: s3c64xx: pm: Add device tree based power
 domain instantiation
In-Reply-To: <52D3D880.2090300@samsung.com>
References: <1389469372-17199-1-git-send-email-tomasz.figa@gmail.com>
 <1389469372-17199-7-git-send-email-tomasz.figa@gmail.com>
 <20140112192910.GW29039@sirena.org.uk> <52D2EE32.5060709@gmail.com>
 <20140113110935.GB29039@sirena.org.uk>
 <52D3D880.2090300@samsung.com>
Message-ID: <20140113121726.GQ29039@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 13, 2014 at 01:13:52PM +0100, Tomasz Figa wrote:

> Power domain control registers are part of the system controller
> block, which uses the "samsung,s3c64*-clock" compatible string. I
> know this is a bit unfortunate, but all registers of this IP block
> are mapped at the same page and some clock registers are at the
> other end of this area than others, so there is even no good way to
> split them into separate mappings.

I see - probably would've been neater to give it a different name but
too late now.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140113/6d85f176/attachment.sig>
