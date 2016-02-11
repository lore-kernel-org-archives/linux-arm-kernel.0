From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 11 Feb 2016 15:59:28 +0100
Subject: [PATCH v2 0/7] irqchip: introduce the Alpine MSIX driver
In-Reply-To: <20160211144544.GC5820@kwain>
References: <1455110583-19515-1-git-send-email-antoine.tenart@free-electrons.com>
 <56BC8F9C.3060505@arm.com> <20160211144544.GC5820@kwain>
Message-ID: <20160211155928.10695bb0@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Thu, 11 Feb 2016 15:45:44 +0100, Antoine Tenart wrote:

> On Thu, Feb 11, 2016 at 01:41:48PM +0000, Marc Zyngier wrote:
> > On 10/02/16 13:22, Antoine Tenart wrote:
> > > 
> > > This series introduce the Alpine MSIX driver, and enables it in both
> > > the Alpine v1 and Alpine v2 device trees.
> > > 
> > > This series depends on "[PATCH v2 0/3] arm64: introduce the Alpine support":
> > > https://lkml.org/lkml/2016/2/10/83
> > > 
> > > You can find the series at:
> > > https://github.com/atenart/linux.git 4.5-rc1/alpinev2-msix
> > 
> > So I'm quite happy with this as it is (modulo the documentation fix on
> > patch 3). I can take the first 3 patches through my GIC tree, but the
> > last 4 patches depend on your other series.
> 
> I'll fix the documentation.
> 
> > Would it be a problem to get these 4 patches merged after 4.6-rc1, so
> > that all the code can be merged before?
> 
> I think we can live with that :)

Practically speaking, patches 4-7 have no build dependency on patches
1-3, so they can be merged independently. As long as the DT binding
introduced in patches 1-3 is validated, then patches 4-7 can be merged
in parallel.

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
