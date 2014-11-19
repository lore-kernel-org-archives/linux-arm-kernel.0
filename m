From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 19 Nov 2014 23:23:34 +0100
Subject: [PATCH] ARM: at91: remove useless init_time for DT-only SoCs
In-Reply-To: <1415604709-24185-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1415604709-24185-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <201411192323.34609.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 10 November 2014, Boris Brezillon wrote:
> Hi Olof,
> 
> You recently pulled some changes on Nicolas' at91-cleanup tag and two of
> those commits (see above for commit hashes) are actually introducing
> compilation errors.
> This patch fixes those compilation errors.
> 

Applied on next/cleanup, thanks!

	Arnd
