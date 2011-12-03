From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 3 Dec 2011 09:14:28 +0000
Subject: [GIT PULL] Identity mapping changes for 3.3
In-Reply-To: <20111202160833.GK5540@mudshark.cambridge.arm.com>
References: <20111202160833.GK5540@mudshark.cambridge.arm.com>
Message-ID: <20111203091428.GK9581@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 02, 2011 at 04:08:33PM +0000, Will Deacon wrote:
> Hi Russell,
> 
> This is the same as the pull request I sent in this thread:
> 
> http://lists.arm.linux.org.uk/lurker/message/20111201.132625.2e9e2d3e.en.html
> 
> I thought I'd better send it as a separate post to highlight it as a PULL.

Thanks.

> The following changes since commit 2d13ccaa8797d7e599f3792aed4b1e44b47f94a5:
> 
>   Merge branch 'irqchip-consolidation' of git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms into devel-stable (2011-11-21 21:56:56 +0000)

As this is known to break some exynos stuff, I'd prefer not to have a pull
request based on this merge - but on the following merge (I've just pushed
out) to reduce the number of commits which are potentially problematical.

Could you base this off my new devel-stable instead?  The head commit
is 53fadbdd83039bb1181e4ff76123d612cdf26c37.
