From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 22 Apr 2013 17:16:45 +0200
Subject: [PATCH 0/4] ARM 64 bit sched_clock take #2
In-Reply-To: <1366417746-24990-1-git-send-email-sboyd@codeaurora.org>
References: <51709FD7.8050408@gmail.com>
 <1366417746-24990-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <201304221716.46105.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 20 April 2013, Stephen Boyd wrote:
> This is what I was thinking. I don't see why we can't move this to generic code
> and have arm64 use it too. Those patches will follow once I find an arm64
> compiler.

I don't have enough background to review the patches, but I know that you can
find an arm64 compiler in Ubuntu Raring. If you are running that on one
of your sysstems, just 'apt-get install gcc-aarch64-linux-gnu'.

	Arnd
