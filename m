From: broonie@kernel.org (Mark Brown)
Date: Thu, 17 May 2018 16:07:43 +0900
Subject: [PATCH v2 2/6] spi: sun6i: handle chip select polarity flag
In-Reply-To: <20180330125047.13936-3-ssuloev@orpaltech.com>
References: <20180330125047.13936-1-ssuloev@orpaltech.com>
 <20180330125047.13936-3-ssuloev@orpaltech.com>
Message-ID: <20180517070743.GQ20254@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 30, 2018 at 03:50:43PM +0300, Sergey Suloev wrote:
> The chip select polarity flag is declared as supported
> but is not handled in the code.

This is more of a fix and should really have come before the cosmetic
changes in patch 1.  In general it's best to put fixes fist in a series
unless there's a strong reason to do something else, that makes it
easier to get the fixes in without them getting caught by review issues
with other code.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180517/ba8466ea/attachment-0001.sig>
