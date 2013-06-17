From: tony@atomide.com (Tony Lindgren)
Date: Sun, 16 Jun 2013 23:20:53 -0700
Subject: [PATCH 2/2] ARM: dts: add AM33XX MMC support
In-Reply-To: <20130615150500.GA27629@arwen.pp.htv.fi>
References: <20130307144656.GR6209@beef>
 <79CD15C6BA57404B839C016229A409A83EC20CCA@DBDE01.ent.ti.com>
 <20130307150408.GU6209@beef>
 <79CD15C6BA57404B839C016229A409A83EC20D27@DBDE01.ent.ti.com>
 <20130307160236.GV6209@beef>
 <79CD15C6BA57404B839C016229A409A83EC213C8@DBDE01.ent.ti.com>
 <CAD=GYpb3+nvoz863+VKO7iJijRHnM5RzsVj-5VJfQ-OHoUy19Q@mail.gmail.com>
 <20130614222537.GA25428@arwen.pp.htv.fi>
 <CAD=GYpYfMAZeV1RUC=DqhYGZaKiiukpTZg7bhO582eKwimS9aA@mail.gmail.com>
 <20130615150500.GA27629@arwen.pp.htv.fi>
Message-ID: <20130617062052.GG20992@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Felipe Balbi <balbi@ti.com> [130615 08:12]:
> 
> fair enough, then let's just add those interrupts to hwmod which will,
> eventually, let us drop all of that data from hwmod.

Nope, we're already dropping the duplicate data from hwmod for
am33xx and omap4. See omap-for-v3.11/cleanup branch.

Regards,

Tony
