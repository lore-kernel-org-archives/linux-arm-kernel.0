From: broonie@kernel.org (Mark Brown)
Date: Mon, 2 Dec 2013 13:54:52 +0000
Subject: [alsa-devel] [PATCH 07/10] ASoC: ux500: Store DMA data in the
 DAI differently in the pdata and DT case
In-Reply-To: <20131202101256.GA29373@lee--X1>
References: <1384859269-19801-1-git-send-email-lee.jones@linaro.org>
 <1384859269-19801-8-git-send-email-lee.jones@linaro.org>
 <CAOesGMiu16f_L=cMWFCNZMjNB9tBK-2LXn02k-R7FhkkgR5-+g@mail.gmail.com>
 <20131202101256.GA29373@lee--X1>
Message-ID: <20131202135452.GI27568@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 02, 2013 at 10:12:56AM +0000, Lee Jones wrote:

> It's actually my fault. I had two patches round the wrong way in the
> series. The imediately subsequent patch in the set fixes this issue:

OK, so what do we do about this?  Is there going to be a revision of
that patch adding the note about not using the autoconfiguration stuff
and what (if any) are the dependencies on the arch/arm changes?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131202/5fc251ff/attachment.sig>
