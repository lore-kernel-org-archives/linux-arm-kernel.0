From: olof@lixom.net (Olof Johansson)
Date: Fri, 23 Jan 2015 14:10:40 -0800
Subject: [Request pull] mvebu/fixes #3
In-Reply-To: <20150122004003.GA9533@lunn.ch>
References: <20150122004003.GA9533@lunn.ch>
Message-ID: <20150123221040.GH20896@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 22, 2015 at 01:40:03AM +0100, Andrew Lunn wrote:
> Hi Olof
> 
> One more fix for 3.19-rc for mvebu, making this the fourth incremental
> pull request.
> 
> Thanks
> 	Andrew
> 
> The following changes since commit 8f1e8ee28660018a935c7576b9af8ffe1feab54c:
> 
>   ARM: mvebu: completely disable hardware I/O coherency (2015-01-17 11:46:55 -0600)
> 
> are available in the git repository at:
> 
>   git://git.infradead.org/linux-mvebu.git tags/mvebu-fixes-3.19-4
> 
> for you to fetch changes up to 38bdf45f4aa5cb6186d50a29e6cbbd9d486a1519:
> 
>   bus: mvebu-mbus: fix support of MBus window 13 (2015-01-19 15:40:53 -0600)
> 
> ----------------------------------------------------------------
> mvebu fixes for 3.19. (Part 4)

Subject says #3, tag says part 4. Hmm?

Also, please use [GIT PULL] and a slightly more descriptive branch name,
please. 

> bus: mvebu-mbus: fix support of MBus window 13

Just having the list of patches in the tag isn't overly useful -- that's
already in the --log part of the merge commit. Instead a few words of
why this branch is needed for 3.19 would be more valuable for us.

Anyway, those are nits and something to keep in mind. I've merged this into
fixes and will send a pull request today or tomorrow.


-Olof
