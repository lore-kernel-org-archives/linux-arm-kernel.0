From: antoine.tenart@free-electrons.com (Antoine Tenart)
Date: Thu, 11 Feb 2016 15:45:44 +0100
Subject: [PATCH v2 0/7] irqchip: introduce the Alpine MSIX driver
In-Reply-To: <56BC8F9C.3060505@arm.com>
References: <1455110583-19515-1-git-send-email-antoine.tenart@free-electrons.com>
 <56BC8F9C.3060505@arm.com>
Message-ID: <20160211144544.GC5820@kwain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Marc,

On Thu, Feb 11, 2016 at 01:41:48PM +0000, Marc Zyngier wrote:
> On 10/02/16 13:22, Antoine Tenart wrote:
> > 
> > This series introduce the Alpine MSIX driver, and enables it in both
> > the Alpine v1 and Alpine v2 device trees.
> > 
> > This series depends on "[PATCH v2 0/3] arm64: introduce the Alpine support":
> > https://lkml.org/lkml/2016/2/10/83
> > 
> > You can find the series at:
> > https://github.com/atenart/linux.git 4.5-rc1/alpinev2-msix
> 
> So I'm quite happy with this as it is (modulo the documentation fix on
> patch 3). I can take the first 3 patches through my GIC tree, but the
> last 4 patches depend on your other series.

I'll fix the documentation.

> Would it be a problem to get these 4 patches merged after 4.6-rc1, so
> that all the code can be merged before?

I think we can live with that :)

Thanks,

Antoine

-- 
Antoine T?nart, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160211/062ef4de/attachment.sig>
