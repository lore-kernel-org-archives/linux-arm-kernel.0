From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 28 Nov 2014 13:47:44 +0100
Subject: [GIT PULL] Allwinner DT for 3.19, bis
In-Reply-To: <20141123163413.GA5585@lukather>
References: <20141123163413.GA5585@lukather>
Message-ID: <201411281347.45210.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday 23 November 2014, Maxime Ripard wrote:
> Arnd, Kevin, Olof,
> 
> Here is the DT pull request for the Allwinner changes that replaces
> the previous one.
> 
> The patch that was breaking the arm-soc boot has been dropped, and
> will go through the clock tree.
> 

Ok. I see that the change between the old and the new branch was the
removal of two patches, so in order to preserve a nicer history,
I undid my earlier revert of the entire branch (which was still on
top) and instead just reverted the two patches, making sure that the
contents are the same as your new branch afterwards.

I've also checked that the new branch makes the boot farm happy.

The part that is still bugging me is that you have apparently done
an incompatible change to the DT binding without even mentioning
which machines are affected or explaining why the compatibility
break was preferrable.

	Arnd
