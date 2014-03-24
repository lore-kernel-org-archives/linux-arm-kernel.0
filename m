From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 24 Mar 2014 16:56:01 +0000
Subject: [PATCH 1/3] ARM: kprobes: Prevent known test failures stopping
 other tests running
In-Reply-To: <1395679745.3465.41.camel@linaro1.home>
References: <1394556894-18592-1-git-send-email-tixy@linaro.org>
 <1394556894-18592-2-git-send-email-tixy@linaro.org>
 <53304CB3.6040409@linaro.org> <1395679745.3465.41.camel@linaro1.home>
Message-ID: <20140324165601.GR7528@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 24, 2014 at 04:49:05PM +0000, Jon Medhurst (Tixy) wrote:
> Yes, I now see this in Russell's patch tracker (with a less verbose
> commit message) as patch 7978, and it's marked as "Applied to git-curr
> (uprobes branch)". Perhaps it got dropped along with the rest of the
> uprobes branch when the config problems were discovered, Russell?

If it was applied to the uprobes branch, and it wasn't part of David's
uprobes git pull request, then yes, it doesn't exist anymore.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
