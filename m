From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 11 Mar 2015 22:50:41 +0100
Subject: [GIT PULL] at91: dt for 4.1 #1
In-Reply-To: <1425744721-27138-1-git-send-email-nicolas.ferre@atmel.com>
References: <1425744721-27138-1-git-send-email-nicolas.ferre@atmel.com>
Message-ID: <4131070.FCHplsfiAq@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 07 March 2015 17:12:01 Nicolas Ferre wrote:
> Arnd, Olof, Kevin,
> 
> This is a first batch of DT updates for 4.1. You'll find many little nodes
> added to several chips and boards. The bulk of it is related to sama5d4 though.
> Sama5d4 Xplained board is also added during this cycle.

Pulled into next/dt.
 
> Please note that this tag is stacked on top of my first at91-fixes pull-request
> that you already took. This is due to a conflict that shows up in the aliases
> section of sama5d4.dtsi.
> I did this to avoid having to deal with this conflict for the whole cycle. If
> you want me to do someting else, please tell me.

No, this is exactly the right way to deal with the conflict, thanks!

	Arnd
