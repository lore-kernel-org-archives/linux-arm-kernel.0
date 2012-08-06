From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 6 Aug 2012 14:30:43 +0000
Subject: [PATCH] arm: add documentation describing Marvell families of SoC
In-Reply-To: <20120806112736.6d441561@skate>
References: <1344115004-7886-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <201208060813.01524.arnd@arndb.de> <20120806112736.6d441561@skate>
Message-ID: <201208061430.43962.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 06 August 2012, Thomas Petazzoni wrote:
> Le Mon, 6 Aug 2012 08:13:01 +0000,
> Arnd Bergmann <arnd@arndb.de> a ?crit :
> 
> > Acked-by: Arnd Bergmann <arnd@arndb.de>
> 
> Thanks. Am I supposed to resend this to Rob Landley <rob@landley.net>,
> who is apparently the Documentation/ maintainer, or can you push it
> through the arm-soc tree since it is Documentation/arm/ material?

Taking this through arm-soc is fine with me, and Russell's ARM
tree would probably work as well.

Should I apply the patch right away, or do you plan to send
it as part of a set of pull requests? In general I would assume
that I get a pull request unless you specifically ask for the
patch to be applied to the arm-soc tree separately (which is
ok for single patches).

Also remember to send any requests for inclusion into arm-soc
(pull or patch) to both Olof and me, since we are taking turns
in the maintainance and you might not know who is doing it
on any given day.

	Arnd
