From: broonie@kernel.org (Mark Brown)
Date: Thu, 17 May 2018 16:03:07 +0900
Subject: [PATCH v2 1/6] spi: sun6i: coding style/readability improvements
In-Reply-To: <20180330125047.13936-2-ssuloev@orpaltech.com>
References: <20180330125047.13936-1-ssuloev@orpaltech.com>
 <20180330125047.13936-2-ssuloev@orpaltech.com>
Message-ID: <20180517070307.GP20254@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 30, 2018 at 03:50:42PM +0300, Sergey Suloev wrote:
> Minor changes to fulfill the coding style and improve
> the readability of the code.
> 
> Changes in v2:
> 1) Fixed issue with misplacing a piece of code that requires access
> to the transfer structure into sun6i_spi_prepare_message() function
> where the transfer structure is not available.

Place inter-version changelogs after the --- as covered in
SubmittingPatches.

> 
> Signed-off-by: Sergey Suloev <ssuloev@orpaltech.com>
> 
> ---
>  drivers/spi/spi-sun6i.c | 97 +++++++++++++++++++++++++++++--------------------

This is a *very* large change doing a whole bunch of different things,
including some fairly substantial changes like moving things into
different functions but the changelog doesn't provide any details at all
on what the changes are supposed to be.  This makes it difficult to
review, it should be split into separate patches each doing one clerly
described thing (I'm guessing this might be part of why the AllWinner
maintainers haven't reviewed the series).
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180517/f12fefa3/attachment-0001.sig>
