From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 02 Oct 2014 14:23:53 +0200
Subject: [GIT PULL] at91: soc for 3.18 #3
In-Reply-To: <1412184003-13568-1-git-send-email-nicolas.ferre@atmel.com>
References: <1412184003-13568-1-git-send-email-nicolas.ferre@atmel.com>
Message-ID: <2674694.XlUc134s25@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 01 October 2014 19:20:03 Nicolas Ferre wrote:
> Arnd, Olof, Kevin,
> 
> Another pull-request for 3.18 if you feel it can be stacked up now. This one is
> *only* about removing code: the old !MMU at91x40 and 2 board files plus the whole
> code in at91sam9g45 & at91sam9rl files for implementing this deprecated method:
> as the EK were the only one to use this code, we remove quite a bunch of lines.
> We can use these boards with DT right now.
> As a matter of fact, the diffstat is pretty nice 
> 

I love the changes, but I've pretty much decided to put a hard stop
on all new pull request after introducing a few regressions with
late submissions.

	Arnd
