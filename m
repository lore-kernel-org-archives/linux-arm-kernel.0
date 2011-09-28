From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 28 Sep 2011 20:24:43 +0100
Subject: [RFC PATCH 3/3] ARM: mm: add l2x0 suspend/resume support
In-Reply-To: <4E81AC1C.4090405@ti.com>
References: <1317047561-11020-1-git-send-email-lorenzo.pieralisi@arm.com>
	<1317047561-11020-4-git-send-email-lorenzo.pieralisi@arm.com>
	<20110926150645.GN22455@n2100.arm.linux.org.uk>
	<20110926171452.GC11647@e102568-lin.cambridge.arm.com>
	<4E815F42.6010102@ti.com>
	<20110927102835.GA18572@e102568-lin.cambridge.arm.com>
	<4E81AC1C.4090405@ti.com>
Message-ID: <20110928192443.GB23944@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 27, 2011 at 04:27:32PM +0530, Santosh Shilimkar wrote:
> I agree. From various discussion so far, apart MX, nobody complained
> about C-version of the code. Hence the comment. If there are more
> platforms which needs it, then the asm version would be useful and
> should be preferred over C-version.

Santosh,

Can you also look at Barry Song's version of this infrastructure as
well?  He posted it a couple of days ago:

Subject: [PATCH v2] ARM: cache-l2x0: add resume entry for l2 in secure mode
Message-ID: <1317007569-31213-1-git-send-email-Baohua.Song@csr.com>

with this diffstat:

 4 files changed, 101 insertions(+), 9 deletions(-)
