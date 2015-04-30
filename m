From: broonie@kernel.org (Mark Brown)
Date: Thu, 30 Apr 2015 11:16:53 +0100
Subject: [PATCH 2/8] spi: sirf: request and free cs gpio in setup and
 cleanup callbacks
In-Reply-To: <CAGsJ_4yhSFnzyZV6B3j90LyJbstsyBJHCnk=LZqVDsL_u8foPQ@mail.gmail.com>
References: <20140906135735.GE2601@sirena.org.uk>
 <D031CA8D.21605%21cnbao@gmail.com>
 <CAGsJ_4yhSFnzyZV6B3j90LyJbstsyBJHCnk=LZqVDsL_u8foPQ@mail.gmail.com>
Message-ID: <20150430101653.GW22845@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 28, 2015 at 11:36:51AM +0800, Barry Song wrote:

> Mark, i'd like to re-call this patch. "pulling the code earlier in
> probe" is impossible based on current SPI core codes. because before
> spi master is registerred,
> cs_gpios is NULL. but once it is registered, cs_gpios are assigned in
> spi_register_master:

I'm afraid I've forgotten what this patch is, sorry.  Can you resend
please?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150430/5e54afa7/attachment-0001.sig>
