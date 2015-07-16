From: tglx@linutronix.de (Thomas Gleixner)
Date: Thu, 16 Jul 2015 13:10:18 +0200 (CEST)
Subject: [PATCH v2 06/13] irqchip: kill off set_irq_flags usage
In-Reply-To: <CAL_JsqJfDdDAQ1gr1w3w8_FVqKzxqDag-PHnwguaPfT+6zqszw@mail.gmail.com>
References: <1436711211-18223-1-git-send-email-robh@kernel.org>
 <1436711211-18223-7-git-send-email-robh@kernel.org>
 <alpine.DEB.2.11.1507121737030.20072@nanos>
 <CAL_JsqJfDdDAQ1gr1w3w8_FVqKzxqDag-PHnwguaPfT+6zqszw@mail.gmail.com>
Message-ID: <alpine.DEB.2.11.1507161309370.18576@nanos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 13 Jul 2015, Rob Herring wrote:
> On Sun, Jul 12, 2015 at 11:43 AM, Thomas Gleixner <tglx@linutronix.de> wrote:
> > So in most of the irqchip drivers, this is irrelevant.
> 
> Agreed, but that's a separate series I think. I'm trying not to change
> behavior with this series. Are you proposing I do something different
> with this patch?

No, consolidating it with no functional change is certainly the right
thing to do first.

Thanks,

	tglx
