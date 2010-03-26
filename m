From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Fri, 26 Mar 2010 11:24:09 +0000
Subject: [GIT PULL] generic arm for MSM
In-Reply-To: <1269557364.21793.52.camel@c-dwalke-linux.qualcomm.com>
References: <1269553937.21793.40.camel@c-dwalke-linux.qualcomm.com>
	<alpine.LFD.2.00.1003251843320.694@xanadu.home>
	<1269557364.21793.52.camel@c-dwalke-linux.qualcomm.com>
Message-ID: <20100326112408.GC27692@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 25, 2010 at 03:49:24PM -0700, Daniel Walker wrote:

> I only based this pull request on next , since I can't get Russell tree
> anyplace else. I've had patches in the past which I've had to use next
> cause there are underlying changes that I can only find in next .. So no
> I don't base development trees on next generally.

You can see what's pulled into -next by looking at the file Trees in the
root of the -next tree, and the specific commits in a given -next can be
seen by looking at the file SHA1s in the same directory.

As people have said you should *never* send any pull requests based on
-next, it's a constantly rebasing merge of various development trees of
varying quality and so will never be merged into mainline.  If you are
sending stuff based on -next for some reason send it as a patches.
