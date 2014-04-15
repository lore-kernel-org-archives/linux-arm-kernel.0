From: broonie@kernel.org (Mark Brown)
Date: Tue, 15 Apr 2014 10:26:09 +0100
Subject: [PATCH 5/5] spi: sirf: fix spi full-duplex DMA transferring issue
In-Reply-To: <CAGsJ_4yO-LGJEkpNy=dizQWjSE3pHEBOrrPndho3jt1_YMRvHg@mail.gmail.com>
References: <1397457001-5266-1-git-send-email-21cnbao@gmail.com>
 <1397457001-5266-6-git-send-email-21cnbao@gmail.com>
 <20140414200628.GX25182@sirena.org.uk>
 <CAGsJ_4yO-LGJEkpNy=dizQWjSE3pHEBOrrPndho3jt1_YMRvHg@mail.gmail.com>
Message-ID: <20140415092609.GJ12304@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 15, 2014 at 09:43:24AM +0800, Barry Song wrote:

> i felt strange too at the first look from internal gerrit. qipan told
> me there is one:
> drivers/spi/spidev.c

OK, that needs fixing.  That code predates anyone doing DMA.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140415/6f4fee84/attachment.sig>
