From: horms@verge.net.au (Simon Horman)
Date: Thu, 1 Nov 2012 09:04:12 +0800
Subject: [PATCH] ARM: shmobile: leave CONFIG_INOTIFY_USER enabled by
 default
In-Reply-To: <Pine.LNX.4.64.1210302358590.29432@axis700.grange>
References: <Pine.LNX.4.64.1210302358590.29432@axis700.grange>
Message-ID: <20121101010411.GB3598@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 31, 2012 at 12:03:45AM +0100, Guennadi Liakhovetski wrote:
> CONFIG_INOTIFY_USER is enabled by default in its Kconfig. Disabling it 
> breaks udevd. Fix shmobile defconfig files to not specify this option 
> explicitly.

Thanks, applied to the defcofigs branch.
I have sent a pull request for the defcofigs branch to the arm-soc people.
I have also rebased the next branch to incorporate this change.

git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git
