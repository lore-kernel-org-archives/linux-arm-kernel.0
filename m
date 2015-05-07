From: broonie@kernel.org (Mark Brown)
Date: Thu, 7 May 2015 10:41:51 +0100
Subject: [PATCH 1/2] spi: sirf: replace kmalloc by devm_kzalloc
In-Reply-To: <CAMuHMdVcKHxasYAF07Cj=EshjOpKhQJnm9crfFPdUb01WzZsWg@mail.gmail.com>
References: <1430982791-8681-1-git-send-email-21cnbao@gmail.com>
 <CAMuHMdVcKHxasYAF07Cj=EshjOpKhQJnm9crfFPdUb01WzZsWg@mail.gmail.com>
Message-ID: <20150507094151.GI22845@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 07, 2015 at 09:25:02AM +0200, Geert Uytterhoeven wrote:

> What about setting SPI_MASTER_MUST_RX and/or SPI_MASTER_MUST_TX,
> and removing the dummy page instead, so the spi core will handle it for you?

Yes, that's what it's there for.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150507/74ac5c30/attachment.sig>
