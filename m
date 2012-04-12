From: afzal@ti.com (Mohammed, Afzal)
Date: Thu, 12 Apr 2012 12:14:24 +0000
Subject: [PATCH 3/9] ARM: at91: add at91sam9g20ek boards dt support
In-Reply-To: <20120412114559.GM16641@game.jcrosoft.org>
References: <20120411153515.GK16641@game.jcrosoft.org>
 <1334160079-30831-3-git-send-email-plagnioj@jcrosoft.com>
 <C8443D0743D26F4388EA172BF4E2A7A9317C7B88@DBDE01.ent.ti.com>
 <20120412114559.GM16641@game.jcrosoft.org>
Message-ID: <C8443D0743D26F4388EA172BF4E2A7A9317C7D68@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jean,

On Thu, Apr 12, 2012 at 17:15:59, Jean-Christophe PLAGNIOL-VILLARD wrote:
> > If ATMEL is also going driver way, then probably our voice together may be
> > heard and hopefully it will expedite the matter.
> I'm going to add it too  my idea was to create something similiar as the
> pintrl
> you register the ddifferent bank supported buy the SoC and then the driver
> request the bank for the dev_name
> 
> at soc level you will set the default timings and then the drvier may
> manipulate them
> 
> I already update the API of sam9_smc to abstract the access to the register.

Is SMC code being converted to driver ?

Regards
Afzal
