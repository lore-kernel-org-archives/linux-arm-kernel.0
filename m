From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 24 Feb 2010 11:37:23 +0000
Subject: New s3c2442 machine
In-Reply-To: <201002241319.01567.anarsoul@gmail.com>
References: <201002241319.01567.anarsoul@gmail.com>
Message-ID: <20100224113722.GD9018@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 24, 2010 at 01:18:53PM +0200, Vasily Khoruzhick wrote:
> Hi, I'm going to submit patch series to add support for s3c2442-based iPAQ 
> rx1950 machine (once again :)). Which kernel tree should I use as base? Ben's 
> next-samsung branch from git.fluff.org or Linus' master branch from 
> git.kernel.org?

In general (not particularly just for this) you're better off working
with -next for things other than bug fixes since that's where any new
code will be applied - except for during the merge window Linus' tree
is always in the process of stabailisation with new development going
on in -next.
