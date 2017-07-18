From: antoine.tenart@free-electrons.com (Antoine Tenart)
Date: Tue, 18 Jul 2017 11:51:30 +0200
Subject: [PATCH] arm64: dts: marvell: mark the cp110 crypto engine as dma
 coherent
In-Reply-To: <87o9si84ej.fsf@free-electrons.com>
References: <20170717073516.26746-1-antoine.tenart@free-electrons.com>
 <87o9si84ej.fsf@free-electrons.com>
Message-ID: <20170718095130.GC2563@kwain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Gregory,

On Tue, Jul 18, 2017 at 11:45:24AM +0200, Gregory CLEMENT wrote:
>  On lun., juil. 17 2017, Antoine Tenart <antoine.tenart@free-electrons.com> wrote:
> 
> > The crypto engines found on the cp110 master and slave are dma coherent.
> > This patch adds the relevant property to their dt nodes.
> 
> Is it a fix?
> 
> Should it go to the current ans stable kernel?

Yes I think that should go into stable. I forgot the stable tag, do you
want me to send a v2 with it included?

Thanks!
Antoine

-- 
Antoine T?nart, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170718/7ad85945/attachment-0001.sig>
