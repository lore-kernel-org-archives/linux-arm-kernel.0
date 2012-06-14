From: afzal@ti.com (Mohammed, Afzal)
Date: Thu, 14 Jun 2012 11:59:09 +0000
Subject: [PATCH 3/3] ARM: OMAP2+: gpmc: handle additional timings
In-Reply-To: <20120614114905.GK12766@atomide.com>
References: <4FD63DBF.9000200@ti.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E997D9E@DBDE01.ent.ti.com>
 <4FD77E35.3050703@ti.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E998767@DBDE01.ent.ti.com>
 <20120613113217.GK12766@atomide.com> <20120613115445.GM12766@atomide.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E998C80@DBDE01.ent.ti.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E999849@DBDE01.ent.ti.com>
 <20120614101901.GI12766@atomide.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E99994C@DBDE01.ent.ti.com>
 <20120614114905.GK12766@atomide.com>
Message-ID: <C8443D0743D26F4388EA172BF4E2A7A93E999ABF@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tony,

On Thu, Jun 14, 2012 at 17:19:06, Tony Lindgren wrote:
> * Mohammed, Afzal <afzal@ti.com> [120614 03:43]:

> > It seems change below should be part of $subject.
> For onenand I'm getting the following error:
> 
> omap2-onenand omap2-onenand: Cannot request GPMC CS 

Without this change (not referring to 3/3, but diff that
was sent in previous mail), was not this error present

Regards
Afzal
