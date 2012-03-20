From: tony@atomide.com (Tony Lindgren)
Date: Tue, 20 Mar 2012 09:51:10 -0700
Subject: [PATCH v2 0/4] ARM: OMAP: boards: changes to support dynamic
 irq alloc
In-Reply-To: <CAC83ZvLf=fkuvf6VN1gwauFirO2cQsNib3ANWnJrujWGNYS24Q@mail.gmail.com>
References: <1332158817-26311-1-git-send-email-tarun.kanti@ti.com>
 <20120319191743.GB9859@atomide.com> <4F67B9F9.1030906@ti.com>
 <20120319233910.GF9859@atomide.com> <4F68471A.4010502@ti.com>
 <CAC83ZvLf=fkuvf6VN1gwauFirO2cQsNib3ANWnJrujWGNYS24Q@mail.gmail.com>
Message-ID: <20120320165109.GG9859@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* DebBarma, Tarun Kanti <tarun.kanti@ti.com> [120320 04:02]:
> On Tue, Mar 20, 2012 at 2:30 PM, Cousson, Benoit <b-cousson@ti.com> wrote:
> > On 3/20/2012 12:39 AM, Tony Lindgren wrote:
> >>
> >> Yes I understand. But still, which patch(s) cause the issue
> >> so we can put that in the changelog for the fixes?
> >
> > OK, here they are:
> > 25db711 gpio/omap: Fix IRQ handling for SPARSE_IRQ
> > 384ebe1 gpio/omap: Add DT support to GPIO driver

Thanks, I'll update the comments for the first two patches
for this and apply them.

If I get an ack from Dmitry for patch 3/4, I'll apply them too.

Regards,

Tony
