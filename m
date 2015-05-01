From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 1 May 2015 18:57:01 +0100
Subject: [PATCH 0/5] Second round of MCPM refactoring
In-Reply-To: <1430496392-15956-1-git-send-email-nicolas.pitre@linaro.org>
References: <1430496392-15956-1-git-send-email-nicolas.pitre@linaro.org>
Message-ID: <20150501175701.GP12732@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 01, 2015 at 12:06:27PM -0400, Nicolas Pitre wrote:
> This is the sequel to the first episode that started here:
> 
> 	http://article.gmane.org/gmane.linux.ports.arm.kernel/401353
> 
> Now that most of the first set has been merged upstream, here's the last
> set to complete the cleanup. This mainly includes the removal of the
> backward compatibility support plus some cosmetic changes.
> 
> The hisi04 backend, though, is instead converted to raw SMP operations
> as it currently doesn't benefit from MCPM at all and doesn't fit well
> with the new backend structure.

Looks like all good stuff.  What's the merging plan for this?

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
