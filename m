From: broonie@kernel.org (Mark Brown)
Date: Tue, 19 Nov 2013 18:53:37 +0000
Subject: [PATCH 00/10] ASoC: dma: ARM: ux500: Obtain DMA data from Device
 Tree
In-Reply-To: <1384859269-19801-1-git-send-email-lee.jones@linaro.org>
References: <1384859269-19801-1-git-send-email-lee.jones@linaro.org>
Message-ID: <20131119185337.GK2674@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 19, 2013 at 11:07:39AM +0000, Lee Jones wrote:

> If this patch-set could go through ASoC as a whole, it would drive down
> the chance of a dependency mess. Vinod has already provided Acks for his
> parts, so it's just between you two Linus and Mark.

I applied the refactoring patches since they didn't seem to depend on
the DMA patches - they're on topic/ux500 in ASoC but I can easily drop
them or they can be merged elsewhere if required (I'll rebase once the
merge window closes anyway).  Let me know and I can provide a tag.

I'm happy to merge the first few patches if that's easiest for everyone
else, let me know and send them to me if that's what works for people.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131119/5c472124/attachment.sig>
