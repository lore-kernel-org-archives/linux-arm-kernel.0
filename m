From: tony@atomide.com (Tony Lindgren)
Date: Fri, 4 Dec 2015 07:46:35 -0800
Subject: [PATCH 1/3] ARM: OMAP2+: Fix SoC detection for dra62x j5-eco
In-Reply-To: <CAALWOA-VmW6rqhL20y65+eNz2ujV=V8+X+f652X=g5LUytvNcQ@mail.gmail.com>
References: <1449184300-15693-1-git-send-email-tony@atomide.com>
 <1449184300-15693-2-git-send-email-tony@atomide.com>
 <CAALWOA-VmW6rqhL20y65+eNz2ujV=V8+X+f652X=g5LUytvNcQ@mail.gmail.com>
Message-ID: <20151204154634.GH23396@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Matthijs van Duin <matthijsvanduin@gmail.com> [151203 18:44]:
> On 4 December 2015 at 00:11, Tony Lindgren <tony@atomide.com> wrote:
> > We can boot dra62x j5-eco using the dm814x code as the clocks and
> > devices are mapped in the device tree. The dra62x is also known
> > as jacinto 5.
> 
> I'm pretty sure the "eco" in the name isn't optional. As far as I know:
> jacinto 5 = dra65x ~ dm814x
> jacinto 5 eco = dra62x ~ dm811x
> jacinto 5 entry = dra61x/60x ~ am335x
> 
> Here ~ means equivalence modulo efuse bits.
> 
> My knowledge of TI's automotive processors is limited however, as is
> public documentation, so perhaps someone from TI can ack or nak this.

OK I'll update to to use "jacinto 5 eco" specifically to avoid more
confusion.

Thanks,

Tony
