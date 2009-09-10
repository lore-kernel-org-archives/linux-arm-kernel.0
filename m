From: eric.y.miao@gmail.com (Eric Miao)
Date: Thu, 10 Sep 2009 20:23:00 +0800
Subject: What's inside the pxa tree for this merge window
In-Reply-To: <20090910115439.GU9410@buzzloop.caiaq.de>
References: <f17812d70909100446h17a1903fy74941945dbfc6943@mail.gmail.com>
	<20090910115439.GU9410@buzzloop.caiaq.de>
Message-ID: <f17812d70909100523l5936e11bpd41354aed622d480@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 10, 2009 at 7:54 PM, Daniel Mack <daniel@caiaq.de> wrote:
> On Thu, Sep 10, 2009 at 07:46:26PM +0800, Eric Miao wrote:
>> Daniel Mack (6):
>> ? ? ? [ARM] pxa: add MFP_PULL_FLOAT
>> ? ? ? [ARM] pxa: add clock definition for graphics controller
>> ? ? ? [ARM] pxa: add device definition for graphics controller
>> ? ? ? [ARM] pxa: rename GCU IRQ for consistency
>
> Regarding the PXA3xx GCU driver:
>
> I really wonder what's wrong with the fbdev people to ignore my very
> simple patch for pxa3xx gcu enabling (not the gcu driver itself but just
> the acceleration ID registration), even after the fifth (or so)
> repost.
>

Mmm... I don't actually see there is any problem with that patch. I can
take it if you are OK.

BTW: do you think CONFIG_PXA3xx_GCU is necessary around the
FB_ACCEL_PXA3xx assignment?
