From: ming.lei@canonical.com (Ming Lei)
Date: Wed, 31 Aug 2011 08:56:41 +0800
Subject: [PATCH] usb: ehci: make HC see up-to-date qh/qtd descriptor ASAP
In-Reply-To: <20110830175432.GG3464@e102144-lin.cambridge.arm.com>
References: <1314720193-26577-1-git-send-email-ming.lei@canonical.com>
	<1314722311.2344.64.camel@deneb.redhat.com>
	<20110830172642.GE3464@e102144-lin.cambridge.arm.com>
	<20110830174859.GA23098@kroah.com>
	<20110830175432.GG3464@e102144-lin.cambridge.arm.com>
Message-ID: <CACVXFVN8PoJqKKBr8gejPHPEiKcv9r3Apskb0mPOPkEMdtuodA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 31, 2011 at 1:54 AM, Will Deacon <will.deacon@arm.com> wrote:

> Although this doesn't have anything to do with ordering; it's all to do with
> immediacy so I think we should try to avoiding using the term `barrier'. If
> this can be made part of the coherent DMA API, that might be the best place
> for it (I can't think of any other areas this is needed given that the
> streaming DMA API and I/O accessors already deal with it).

Agree too.


thanks,
--
Ming Lei
