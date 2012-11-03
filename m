From: vaibhav.bedia@ti.com (Bedia, Vaibhav)
Date: Sat, 3 Nov 2012 08:39:21 +0000
Subject: [PATCH 02/15] ARM: OMAP2+: mailbox: Add support for AM33XX
In-Reply-To: <CA+Bv8XY8x=BDgGDNHPMRqz3xUbzKf8+o0MJQDovHY+NqBh6NVw@mail.gmail.com>
References: <1351859566-24818-1-git-send-email-vaibhav.bedia@ti.com>
 <1351859566-24818-3-git-send-email-vaibhav.bedia@ti.com>
 <CA+Bv8XY8x=BDgGDNHPMRqz3xUbzKf8+o0MJQDovHY+NqBh6NVw@mail.gmail.com>
Message-ID: <B5906170F1614E41A8A28DE3B8D121433EBFE61A@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russ,

On Sat, Nov 03, 2012 at 05:44:21, Russ Dill wrote:
[...]
> > -       if (!cpu_is_omap44xx())
> > +       if (!cpu_is_omap44xx() || !soc_is_am33xx())
> >                 bit = mbox_read_reg(p->irqdisable) & ~bit;
> 
> Do you mean &&?
> 

I didn't change that line but it looks ok to me :)

Regards,
Vaibhav
