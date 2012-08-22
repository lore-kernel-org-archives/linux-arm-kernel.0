From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 22 Aug 2012 20:11:40 +0100
Subject: [PATCH v3 2/9] ARM: OMAP: mcbsp: Enable FIFO use for OMAP2430
In-Reply-To: <1345124468-8876-3-git-send-email-peter.ujfalusi@ti.com>
References: <1345124468-8876-1-git-send-email-peter.ujfalusi@ti.com>
 <1345124468-8876-3-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <20120822191139.GI7995@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 16, 2012 at 04:41:01PM +0300, Peter Ujfalusi wrote:
> On OMAP2430 all McBSP ports have 128 word long buffer, enable the use of
> the FIFO for the audio stack.
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> Acked-by: Jarkko Nikula <jarkko.nikula@bitmer.com>

I applied this - Tony, from the thread it seemed you were OK even though
you didn't explicitly ack it?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120822/fa0b84af/attachment-0001.sig>
