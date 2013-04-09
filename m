From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 9 Apr 2013 20:32:18 +0200
Subject: [PATCHv2] ARM: Push selects for TWD/SCU into machine entries
In-Reply-To: <5164462E.4010706@codeaurora.org>
References: <1362007694-3419-1-git-send-email-sboyd@codeaurora.org>
 <5151DC41.7090307@codeaurora.org> <5164462E.4010706@codeaurora.org>
Message-ID: <201304092032.18885.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 09 April 2013, Stephen Boyd wrote:
> >>>
> >>> Sneaking it in through the fixes branch would make life easier for us,
> >>> but it doesn't feel right.
> >> Arnd, can you pick this up into the arm-soc tree now? It would be good
> >> to get this into next so that conflicts are avoided later on.
> >>
> > Arnd?
> >
> 
> Ping?


Sorry for the long delay, you scrolled down from my unread emails twice.

Three tips for you to make it more likely to get a fast reaction time:

* Send the original patch to Olof and me, not just the reply to the
  on-list patch.
* Use the arm at kernel.org alias to reach us, since that will make the
  email go into the right folder
* Use the [GIT PULL] keyword in the subject line, ideally sending a
  pull request as well, instead of a separate email. While we do apply
  emails, It's often batch processing to apply everything and then
  we scan for emails that have PULL in the subject, while others
  can get lost.

I've applied it to the next/soc branch now.

	Arnd
