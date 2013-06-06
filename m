From: tony@atomide.com (Tony Lindgren)
Date: Thu, 6 Jun 2013 08:55:41 -0700
Subject: [PATCH 0/5] Broken DM816x support in Linux 3.10-rc4
In-Reply-To: <alpine.DEB.2.02.1306060414580.15042@utopia.booyaka.com>
References: <1370446156-11788-1-git-send-email-aida.mynzhasova@skitlab.ru>
 <alpine.DEB.2.02.1306060414580.15042@utopia.booyaka.com>
Message-ID: <20130606155541.GM3331@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Paul Walmsley <paul@pwsan.com> [130605 21:22]:
> Hi,
> 
> also,
> 
> On Wed, 5 Jun 2013, Aida Mynzhasova wrote:
> 
> > Aida Mynzhasova (5):
> >   ARM: OMAP: AM33xx: multiple renames for early initialization
> 
> If this patch is what's responsible for all the file renaming, please drop 
> it.  Looks from the change summary that it's just useless churn (although 
> I haven't seen the patch here since it never made it to the lists)

Yes no reason for all the renaming, marketing names can be
whatever. For example, we have am/dm37xx too which is really
omap36xx.

Regards,

Tony
