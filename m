From: eric@anholt.net (Eric Anholt)
Date: Wed, 27 Apr 2016 11:54:04 -0700
Subject: [PATCH 2/2] ASoC: bcm2835: Add S16_LE support via packed DMA
 transfers
In-Reply-To: <1461763613-28714-2-git-send-email-hias@horus.com>
References: <1461763613-28714-1-git-send-email-hias@horus.com>
 <1461763613-28714-2-git-send-email-hias@horus.com>
Message-ID: <878tzyublf.fsf@eliezer.anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Matthias Reichl <hias@horus.com> writes:

> The bcm2835-i2s driver already has support for the S16_LE format but
> that format hasn't been made available because dmaengine_pcm didn't
> support packed data transfers.

Acked-by: Eric Anholt <eric@anholt.net>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 818 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160427/ba3c9683/attachment.sig>
