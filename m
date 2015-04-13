From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 14 Apr 2015 01:52:16 +0200
Subject: [GIT PULL] at91: cleanup for 4.1 #4 (bis)
In-Reply-To: <1428265043-10366-1-git-send-email-nicolas.ferre@atmel.com>
References: <20150403180556.GK23023@localhost>
 <1428265043-10366-1-git-send-email-nicolas.ferre@atmel.com>
Message-ID: <201504140152.16375.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday 05 April 2015, Nicolas Ferre wrote:
> Fourth batch of cleanup for 4.1:
> - 1 issues revealed by the kbuild test robot fixed
> - move of some functions and macros into relevant files to be able to
>   streamline the at91 specific header afterwards
> 

As we should really have the bug fix in the next/multiplatform branch,
I've pulled all of this in.

Sorry for the delay, I hope we don't get into trouble for adding
this too late.

	Arnd
