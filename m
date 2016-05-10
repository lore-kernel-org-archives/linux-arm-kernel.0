From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 10 May 2016 11:30:31 +0200
Subject: [GIT PULL] at91: fixes for 4.6 #1
In-Reply-To: <1462865249-28552-1-git-send-email-nicolas.ferre@atmel.com>
References: <1462865249-28552-1-git-send-email-nicolas.ferre@atmel.com>
Message-ID: <5465950.OCrl9K6RLM@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 10 May 2016 09:27:29 Nicolas Ferre wrote:
> Here is a late fix for AT91. Sorry to have figure it out so late in the
> development cycle but we had to confirm it was an error with the documentation
> of two products.
> So, as the compatibility string is in since 4.6-rc1 and that the previous one
> works okay, it's a good opportunity to switch back to the one that works without
> introducing a intermediary bug.
> The revert on driver code and the removal of the useless additional
> compatibility string will be queued for 4.7 through NAND/MTD.

Thanks, pulled into the fixes. I ended up taking the text above as the
commit log for the merge, as it was more descriptive than the shorter
version you had in the tag.

	Arnd
