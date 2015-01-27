From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 27 Jan 2015 14:24:02 +0100
Subject: [PATCH v8 0/2] Add Spreadtrum SoC bindings and serial driver
 support
In-Reply-To: <1422345407-10037-1-git-send-email-chunyan.zhang@spreadtrum.com>
References: <1422345407-10037-1-git-send-email-chunyan.zhang@spreadtrum.com>
Message-ID: <2196748.ag4UzqF1Px@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 27 January 2015 15:56:45 Chunyan Zhang wrote:
> This patch-set split the last version, and addressed the review comments from
> last version on serial driver code.
> 
> Changes from v7:
> * Addressed review comments from Peter:
>         - Initialized the stack local with zero in sprd_set_termios()
>         - Used dev_get_drvdata() to get sprd_uart_port
> 

Looks good to me, but you still have too many people on 'To', so Greg
might be missing that you expect him to merge it.

Greg, if there are no further comments, can you take both patches through
the tty git?

	Arnd
