From: broonie@kernel.org (Mark Brown)
Date: Mon, 2 Dec 2013 14:04:29 +0000
Subject: [alsa-devel] [PATCH 07/10] ASoC: ux500: Store DMA data in the
 DAI differently in the pdata and DT case
In-Reply-To: <20131202140324.GH31626@lee--X1>
References: <1384859269-19801-1-git-send-email-lee.jones@linaro.org>
 <1384859269-19801-8-git-send-email-lee.jones@linaro.org>
 <CAOesGMiu16f_L=cMWFCNZMjNB9tBK-2LXn02k-R7FhkkgR5-+g@mail.gmail.com>
 <20131202101256.GA29373@lee--X1>
 <20131202135452.GI27568@sirena.org.uk>
 <20131202140324.GH31626@lee--X1>
Message-ID: <20131202140429.GJ27568@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 02, 2013 at 02:03:24PM +0000, Lee Jones wrote:

> I'm not aware of any dependencies on the ARM changes. I haven't tested
> the arch/arm and sound/soc adaptions orthogonally, but I _think_ the
> right decisions should be made depending on the information passed
> from platform/dt code.

OK, that sounds great thanks.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131202/0109c50b/attachment.sig>
