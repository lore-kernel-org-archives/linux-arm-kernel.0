From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 11 Mar 2015 23:08:18 +0100
Subject: [GIT PULL] Second Round of Renesas ARM Based SoC Cleanup for v4.1
In-Reply-To: <cover.1425947508.git.horms+renesas@verge.net.au>
References: <cover.1425947508.git.horms+renesas@verge.net.au>
Message-ID: <2060391.06thMe3uM7@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 10 March 2015 09:42:09 Simon Horman wrote:
> Please consider these second round of Renesas ARM based SoC cleanup for v4.1.
> 
> This pull request is based on the previous round of
> such requests, tagged as renesas-soc-cleanup-for-v4.1,
> which you have already pulled.
> 

I had grouped the renesas-soc-cleanup-for-v4.1 into next/multiplatform
rather than next/cleanup, and would like to keep the two separate
unless there is a good reason not to.

If you haven't already based other work on top of renesas-soc-cleanup2-for-v4.1
and there are no other conflicts, could you rebase it to -rc1?

	Arnd
