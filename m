From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 01 Jun 2013 11:03:54 +0200
Subject: [PATCH 11/15] iwlegacy: il_pm_ops is only provided for PM_SLEEP
In-Reply-To: <CAN8TOE8Y_2RMSrgMw7KwML88_1VA=QcJwuuMKEZpZCF5_dAQ=w@mail.gmail.com>
References: <1370038972-2318779-1-git-send-email-arnd@arndb.de>
 <1370038972-2318779-12-git-send-email-arnd@arndb.de>
 <CAN8TOE8Y_2RMSrgMw7KwML88_1VA=QcJwuuMKEZpZCF5_dAQ=w@mail.gmail.com>
Message-ID: <1782157.poHidi6zEK@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 31 May 2013 22:43:23 Brian Norris wrote:
> On Fri, May 31, 2013 at 3:22 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> > This makes sure the conditionals for the declaration match the
> > definition, so we provide the alternative
> >
> >  #else
> >  #define IL_LEGACY_PM_OPS NULL
> >  #endif
> >
> > in the correct cases. As suggested by Borislav Petkov, this removes
> > the comments for the #else and #endif lines.
> 
> You seem to have missed the #endif line.

Yes, I screwed it up with a last minute change, sorry about this.
Will follow up with a new one.

	Arnd
