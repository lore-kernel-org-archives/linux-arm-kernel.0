From: matthijsvanduin@gmail.com (Matthijs van Duin)
Date: Fri, 4 Dec 2015 03:43:10 +0100
Subject: [PATCH 1/3] ARM: OMAP2+: Fix SoC detection for dra62x j5-eco
In-Reply-To: <1449184300-15693-2-git-send-email-tony@atomide.com>
References: <1449184300-15693-1-git-send-email-tony@atomide.com>
 <1449184300-15693-2-git-send-email-tony@atomide.com>
Message-ID: <CAALWOA-VmW6rqhL20y65+eNz2ujV=V8+X+f652X=g5LUytvNcQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4 December 2015 at 00:11, Tony Lindgren <tony@atomide.com> wrote:
> We can boot dra62x j5-eco using the dm814x code as the clocks and
> devices are mapped in the device tree. The dra62x is also known
> as jacinto 5.

I'm pretty sure the "eco" in the name isn't optional. As far as I know:
jacinto 5 = dra65x ~ dm814x
jacinto 5 eco = dra62x ~ dm811x
jacinto 5 entry = dra61x/60x ~ am335x

Here ~ means equivalence modulo efuse bits.

My knowledge of TI's automotive processors is limited however, as is
public documentation, so perhaps someone from TI can ack or nak this.

Matthijs
