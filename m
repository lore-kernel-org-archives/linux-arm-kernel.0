From: rostedt@goodmis.org (Steven Rostedt)
Date: Fri, 13 Dec 2013 11:11:40 -0500
Subject: [PATCH v6 7/7] jump_label: use defined macros instead of
 hard-coding for better readability
In-Reply-To: <20131213160041.GK19177@mudshark.cambridge.arm.com>
References: <1386691433-6827-1-git-send-email-liuj97@gmail.com>
 <1386691433-6827-8-git-send-email-liuj97@gmail.com>
 <20131213160041.GK19177@mudshark.cambridge.arm.com>
Message-ID: <20131213111140.064b9616@gandalf.local.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


[ added Jason Baron too (the original author) ]

On Fri, 13 Dec 2013 16:00:41 +0000
Will Deacon <will.deacon@arm.com> wrote:

> On Tue, Dec 10, 2013 at 04:03:53PM +0000, Jiang Liu wrote:
> > Use macro JUMP_LABEL_TRUE_BRANCH instead of hard-coding for better
> > readability.
> > 
> > Signed-off-by: Jiang Liu <liuj97@gmail.com>
> > ---
> >  include/linux/jump_label.h | 15 ++++++++++-----
> >  1 file changed, 10 insertions(+), 5 deletions(-)
> 
> Whilst this looks alright to me, I think we probably need an ack from Steve
> in order to take changes to the core code.
> 
> Will
> 

Thanks for the heads up. I'll take a look at it.

-- Steve
