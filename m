From: gururaja.hebbar@ti.com (Hebbar, Gururaja)
Date: Fri, 31 May 2013 06:46:42 +0000
Subject: [PATCH 1/2] rtc: omap: add option to indicate wakeup support
 through DT
In-Reply-To: <CA+V-a8vAM_4qC20Fpipu3tROs65dERoFgV-ypyJh336rir-0EQ@mail.gmail.com>
References: <1369982005-8572-1-git-send-email-gururaja.hebbar@ti.com>
 <1369982005-8572-2-git-send-email-gururaja.hebbar@ti.com>
 <CA+V-a8vAM_4qC20Fpipu3tROs65dERoFgV-ypyJh336rir-0EQ@mail.gmail.com>
Message-ID: <1BAFE6F6C881BF42822005164F1491C33EC1E168@DBDE04.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 31, 2013 at 12:14:44, Prabhakar Lad wrote:
> Hi Gururaja,
> 
> Thanks for the patch.
> 
> On Fri, May 31, 2013 at 12:03 PM, Hebbar Gururaja
> <gururaja.hebbar@ti.com> wrote:
> > Even though RTC-IP is wakeup capable, Not all Boards support it.
> >
> > For example
> > The rtc alarm wakeup is available in rtc-ip since omap1 days but alarm
> > was not wired properly in previous ompa1 boards.
> >
> [snip]
> >
> > +Optional properties:
> > +- ti,wakeup_capable: Inform the rtc driver that this module is wake-up
> For devicetree properties '-' is preferred over '_'.

Thanks for the review. I will make the correction. But will wait for some 
more time (so others can review) and then send V2

> 
> Regards,
> --Prabhakar Lad
> 


Regards, 
Gururaja
