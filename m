From: broonie@kernel.org (Mark Brown)
Date: Sat, 6 Sep 2014 14:55:50 +0100
Subject: [PATCH 8/8] spi: sirf: make DMA transfer mode optional
In-Reply-To: <CAGsJ_4ysw0vy93N4evG_Aq2mMuymVXY6ig2U0EQBwQmz3uMyNA@mail.gmail.com>
References: <1409648557-5470-1-git-send-email-Barry.Song@csr.com>
 <1409648557-5470-4-git-send-email-Barry.Song@csr.com>
 <20140904224132.GW29327@sirena.org.uk>
 <CAGsJ_4ysw0vy93N4evG_Aq2mMuymVXY6ig2U0EQBwQmz3uMyNA@mail.gmail.com>
Message-ID: <20140906135550.GD2601@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 05, 2014 at 04:14:17PM +0800, Barry Song wrote:

> i have no strong technical reason for this as the benefit is not
> always technical. you know....the commit log has provided the reason
> for this patch.
> the difficulty for me is maintaining the difference between mainline
> and local codes, but if we have to maintain two copies,  we can.

OK, well I think that's best though it would be better if we were able
to understand what benefit your customers believe they are seeing here
and hopefully address it in a better way.  Doing this sort of thing with
Kconfig options is not great, especially when you start trying to build
kernels that work with more than one board.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140906/55f9e139/attachment.sig>
