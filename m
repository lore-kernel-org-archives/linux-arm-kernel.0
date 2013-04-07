From: arnd@arndb.de (Arnd Bergmann)
Date: Sun, 7 Apr 2013 23:04:45 +0200
Subject: [PATCH 00/14] Ux500 multiplatform v2
In-Reply-To: <20130407205216.GB24058@zurbaran>
References: <1365171776-8463-1-git-send-email-linus.walleij@stericsson.com>
 <201304051713.54233.arnd@arndb.de> <20130407205216.GB24058@zurbaran>
Message-ID: <201304072304.46159.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday 07 April 2013, Samuel Ortiz wrote:
> On Fri, Apr 05, 2013 at 05:13:54PM +0200, Arnd Bergmann wrote:
> > On Friday 05 April 2013, Linus Walleij wrote:

> I am fine with Linus' changes. Would it be possible for you to setup a branch
> where I could also pull those changes from ? Or are the interdependencies too
> strong to do so ?

Sure, I always create a stable branch for each pull request I get for this
purpose anyway. Actually it might be nice if Linus could produce two branches:
One that has the MFD changes only, and the second one based on the first that
adds all the remaining changes. Then you can pull in just the first branch
and don't need to add too many changes outside of drivers/mfd to your tree.

I don't think that the patches depend on anything that is already in arm-soc,
but we might need to add other changes on top.

	Arnd
