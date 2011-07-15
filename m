From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 15 Jul 2011 18:09:04 +0200
Subject: [GIT PULL] Tegra updates for v3.1
In-Reply-To: <CAMbhsRQLaZss2uhLCaY-WjaH85WKLbYYnR2cfw4b+Qnz_rKXyw@mail.gmail.com>
References: <CAMbhsRQoZ7vJGchkXLUOrOH4rpKJzJe-iGvLjTfBmz4R=8HtVw@mail.gmail.com>
	<201107151600.40794.arnd@arndb.de>
	<CAMbhsRQLaZss2uhLCaY-WjaH85WKLbYYnR2cfw4b+Qnz_rKXyw@mail.gmail.com>
Message-ID: <201107151809.04667.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 15 July 2011, Colin Cross wrote:
> If I put it in separate branches in the future, do you want a single
> pull request for a merge of the branches, or a pull request for each
> branch?

Separate requests. The idea is that I can group them together with
similar branches from other platforms and then send a single
pull request to Linus for e.g. all fixes, or a specific feature
getting added to multiple platforms.

The branches that I commonly have for other platforms are 'fixes',
'cleanup', 'devel' and 'board'. If you have a lot of patches, like
omap typically has, you can also do more specific feature branches.

In the future, I hope to see a lot more device tree work, which should
also have its own branch.

	Arnd
