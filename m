From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 28 Apr 2014 11:12:14 -0600
Subject: [PATCH 00/16] Another 16 L2C patches
In-Reply-To: <20140428165631.GM26756@n2100.arm.linux.org.uk>
References: <20140428165631.GM26756@n2100.arm.linux.org.uk>
Message-ID: <535E8BEE.1000100@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/28/2014 10:56 AM, Russell King - ARM Linux wrote:
> So, in response to Matt Porter's complaint about breaking prima2, here's
> another 16 patches which changes the way the L2 cache is initialised on
> many platforms.  This series moves towards a situation where the generic
> code initialises the L2 cache itself, with as little help as possible
> from board specific code.
> 
> A number of platforms are left alone because they're more complex -
> these should still eventually be converted.
> 
> At some point in the near future, I will see about sorting out their
> ordering wrt the previous patch set.  For the time being, they apply
> on top of the existing l2c changes.

Are "the existing l2c changes" in next-20140428? If not, is there a git
branch I can pull to test the whole thing, rather than tracking down and
applying "the existing l2c changes" first?
