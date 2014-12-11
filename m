From: jean-michel.hautbois@vodalys.com (Jean-Michel Hautbois)
Date: Thu, 11 Dec 2014 15:44:06 +0100
Subject: omap3505: HECC support and DT ?
Message-ID: <CAL8zT=izk+xk=v0M0F5DSgSySaGvkPWWZdCd43i8Z6bwQt7MAg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi !

I have a custom board with a AM3505.
I am trying to use linux 3.18 and I have difficulties making it work.
What is needed in order to get it declared in DT ?
Is it still needed to have a board-am3517-myboard.c ?

I have a few drivers like that I need to bring up (a Micrel KSZ8873
for example) where the drivers exist, but a DT binding seems to be
missing.
But I may have missed the information, hence my question :).

Thanks in advance,
JM
