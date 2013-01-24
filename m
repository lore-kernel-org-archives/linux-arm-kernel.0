From: jason@lakedaemon.net (Jason Cooper)
Date: Wed, 23 Jan 2013 20:33:12 -0500
Subject: [RFC PATCH 0/6] ARM: kirkwood: cleanup DT conversion
In-Reply-To: <cover.1358983578.git.jason@lakedaemon.net>
References: <cover.1358983578.git.jason@lakedaemon.net>
Message-ID: <20130124013312.GW1758@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 23, 2013 at 11:34:18PM +0000, Jason Cooper wrote:
> All,
> 
> This is a first cut at cleaning up mach-kirkwood/.  There are a few DT
> conversions (topkick -> mvsdio, pinctrl) which, once reviewed, I'll put in the
> normal pull request cycle.
> 
> The others which remove board-*.c files, I'll keep updating against
> mvebu/for-next, and then apply at the end of the merge window.
> 
> Please test as you are able.

I should also mention, this was built against mvebu/for-next (not
stable) which is just the merging of all the mvebu/* branches and
arm-soc/for-next into one branch.

thx,

Jason.
