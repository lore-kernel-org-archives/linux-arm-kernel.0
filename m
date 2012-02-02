From: nsekhar@ti.com (Nori, Sekhar)
Date: Thu, 2 Feb 2012 19:53:11 +0000
Subject: [PATCH v3] ARM: davinci: map default_queue to edma channels
In-Reply-To: <4F28DE58.3040902@denx.de>
References: <1326956721-25158-1-git-send-email-hs@denx.de>
 <DF0F476B391FA8409C78302C7BA518B6317970CE@DBDE01.ent.ti.com>
 <4F28DE58.3040902@denx.de>
Message-ID: <DF0F476B391FA8409C78302C7BA518B6317AE7C6@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Heiko,

On Wed, Feb 01, 2012 at 12:10:24, Heiko Schocher wrote:
> Hello Nori,
> 
> Nori, Sekhar wrote:
> > Hi Heiko,
> > 
> > On Thu, Jan 19, 2012 at 12:35:21, Heiko Schocher wrote:
> >> Default queue is expected to be a low-priority queue.
> >> This way, long transfers on the default queue started
> >> by the codec engine will not cause audio defects.
> >>
> >> Signed-off-by: Heiko Schocher <hs@denx.de>
> > 
> >> Signed-off-by: juha.kuikka at gmail.com
> >> Reported-by: juha.kuikka at gmail.com
> > 
> > Sign-off should include real name, so I changed these
> > two lines to:
> > 
> >     Signed-off-by: Juha Kuikka <juha.kuikka@gmail.com>
> >     Reported-by: Juha Kuikka <juha.kuikka@gmail.com>
> 
> Thanks!
> 
> > before applying. Let me know if anyone has objections.
> 
> I saw no objections, so can this patch go in now?

Queuing this for v3.4. Thanks for the reminder.

Regards,
Sekhar
