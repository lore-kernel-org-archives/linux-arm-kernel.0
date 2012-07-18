From: lethal@linux-sh.org (Paul Mundt)
Date: Wed, 18 Jul 2012 09:52:30 +0900
Subject: Boot breaks in -next from LEGACY to LINEAR conversion
In-Reply-To: <20120717185749.GJ4477@opensource.wolfsonmicro.com>
References: <20120717185749.GJ4477@opensource.wolfsonmicro.com>
Message-ID: <20120718005230.GA15680@linux-sh.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 17, 2012 at 07:57:49PM +0100, Mark Brown wrote:
> -next fails to boot for me today on my s3c64xx based systems.  Walking
> back to the last time I tried and bisecting likely branches I find that
> commit 910139 (irqdomain: Replace LEGACY mapping with LINEAR) is the one
> that introduces the build break.  Unfortunately the boot fails before I
> get a console which makes diagnosis somewhat more tricky than would be
> ideal.  Any ideas?

Does http://www.spinics.net/lists/linux-sh/msg11995.html fix it for you?

I did Cc you on the legacy -> linear thread, but perhaps you missed it.
