From: nm@ti.com (Nishanth Menon)
Date: Mon, 21 Jul 2014 06:17:38 -0500
Subject: [RFC PATCH 3/7] ARM: OMAP4+: PRM: remove "wkup" event
In-Reply-To: <20140721104413.GT18374@atomide.com>
References: <1402025761-16831-1-git-send-email-nm@ti.com>
 <1402025761-16831-4-git-send-email-nm@ti.com>
 <20140721104413.GT18374@atomide.com>
Message-ID: <CAGo_u6ryytHiV1dnkPx-qFGa4ZB3KxVDrjmA+Ls5bakHVLunsQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 21, 2014 at 5:44 AM, Tony Lindgren <tony@atomide.com> wrote:
>
> Hmm so why was it added originally then?
>
> Do the PRM_IRQSTATUS line and the following line belong together
> or is it missing something?


Seems like to have been a copy paste from OMAP3 code which did have
wakeup event at bit 0.

-- 
---
Regards,
Nishanth Menon
