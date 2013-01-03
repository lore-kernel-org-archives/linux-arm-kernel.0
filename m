From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 3 Jan 2013 16:33:24 +0000
Subject: [PATCH 133/493] remove use of __devexit_p
In-Reply-To: <1353349642-3677-133-git-send-email-wfp5p@virginia.edu>
References: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
 <1353349642-3677-133-git-send-email-wfp5p@virginia.edu>
Message-ID: <201301031633.24214.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 19 November 2012, Bill Pemberton wrote:
> CONFIG_HOTPLUG is going away as an option so __devexit_p is no longer
> needed.

I've seen a few cases where __devexit was incorrectly paired with __exit_p().
Have you checked for those as well? It may be worth removing those at the
same time.

	Arnd
