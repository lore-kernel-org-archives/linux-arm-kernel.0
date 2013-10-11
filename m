From: broonie@kernel.org (Mark Brown)
Date: Fri, 11 Oct 2013 17:03:09 +0100
Subject: [PATCH v4 0/5] dma: mxs-dma bugfixes and cleanup
In-Reply-To: <CAOMZO5AG_efwTbtUjG8TPEY=_kyjrcZkEQV6XfZ6CLZ3_msWig@mail.gmail.com>
References: <1381493539-31756-1-git-send-email-mpa@pengutronix.de>
 <CAOMZO5AG_efwTbtUjG8TPEY=_kyjrcZkEQV6XfZ6CLZ3_msWig@mail.gmail.com>
Message-ID: <20131011160309.GE2443@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 11, 2013 at 11:01:29AM -0300, Fabio Estevam wrote:

> The problem I see is that randomly the captured audio becomes
> extremely noisy and loud (throughout the whole 10 seconds) and then in
> the subsequent loop it becomes normal. This is very random and it
> happens at a 1 or 2% failure rate.

This sounds like there's a problem with L/R sync or noise on the bit
clock and the samples aren't being well aligned with the clock.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131011/416eef1c/attachment.sig>
