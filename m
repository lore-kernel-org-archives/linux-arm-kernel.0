From: antoine.tenart@free-electrons.com (Antoine Tenart)
Date: Tue, 23 May 2017 09:13:07 +0200
Subject: [PATCH v5 1/4] Documentation/bindings: Document the SafeXel
 cryptographic engine driver
In-Reply-To: <20170522213416.7440ee32@free-electrons.com>
References: <20170522144514.6654-1-antoine.tenart@free-electrons.com>
 <20170522144514.6654-2-antoine.tenart@free-electrons.com>
 <20170522213416.7440ee32@free-electrons.com>
Message-ID: <20170523071307.GA5465@kwain.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas,

On Mon, May 22, 2017 at 09:34:16PM +0200, Thomas Petazzoni wrote:
> On Mon, 22 May 2017 16:45:11 +0200, Antoine Tenart wrote:
> > +		interrupts = <GIC_SPI 34 (IRQ_TYPE_EDGE_RISING | IRQ_TYPE_LEVEL_HIGH)>,
> 
> You already got the feedback previously that an interrupt that is both
> edge and level at the same time doesn't make sense. Could you fix this?
> 
> Also, the DTs that have already been merged by Gr?gory are wrong for
> the same reason and should be fixed.

Sure, I'll fix this and send a new version :)

Thanks,
Antoine

-- 
Antoine T?nart, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
