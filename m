From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Thu, 31 Jan 2013 23:00:51 -0500 (EST)
Subject: [PATCH v4 00/13] ARM LPAE Fixes - Part 1
In-Reply-To: <1359669512-31276-1-git-send-email-cyril@ti.com>
References: <1359669512-31276-1-git-send-email-cyril@ti.com>
Message-ID: <alpine.LFD.2.02.1301312252230.6300@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 31 Jan 2013, Cyril Chemparathy wrote:

> This series is a repost of the LPAE related changes in preparation for the
> introduction of the Keystone sub-architecture.  The original series has now
> been split, and this particular series excludes the earlier changes to the
> runtime code patching implementation.  Earlier versions of this series can be
> found at [1], [2], [3] and [4].
> 
> These patches are also available in git:
> git://git.kernel.org/pub/scm/linux/kernel/git/cchemparathy/linux-keystone.git upstream/keystone-lpae-v4

This part 1 looks very nice.  It received many review cycles already as 
well.  It would be about time it goes upstream.

I think it is ready to be merged in Russell's tree.  Feel free to send 
him a pull request whenever you're ready.

Then we'll be free to look at the more controvertial p2v patching stuff.


Nicolas
