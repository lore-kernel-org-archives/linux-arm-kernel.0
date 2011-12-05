From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 5 Dec 2011 08:55:37 +0000
Subject: [PATCH v2] ARM: restart: davinci: use new restart hook
In-Reply-To: <DF0F476B391FA8409C78302C7BA518B603B24E@DBDE01.ent.ti.com>
References: <1322513934-23069-1-git-send-email-nsekhar@ti.com>
 <DF0F476B391FA8409C78302C7BA518B603B24E@DBDE01.ent.ti.com>
Message-ID: <20111205085537.GE14542@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 05, 2011 at 08:51:46AM +0000, Nori, Sekhar wrote:
> Hi Russell,
> 
> On Tue, Nov 29, 2011 at 02:28:54, Nori, Sekhar wrote:
> > Rather than using DaVinci specific davinci_soc_info based
> > restart hook, use the restart hook available in the machine
> > descriptor instead.
> > 
> > Tested on DM365 and AM18x EVMs.
> > 
> > v2:
> > Changed to use restart hook in machine descriptor
> > per Russell's comment.
> > 
> > Signed-off-by: Sekhar Nori <nsekhar@ti.com>
> 
> If you are OK with this patch, I will put it into
> your patch system?

Yes please.
