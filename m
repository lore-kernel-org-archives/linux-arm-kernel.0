From: akpm@linux-foundation.org (Andrew Morton)
Date: Wed, 27 Jan 2010 14:12:08 -0800
Subject: [PATCH] Flush dcache before writing into page to avoid alias
In-Reply-To: <20100127215959.GC15325@Chamillionaire.breakpoint.cc>
References: <979dd0561001202107v4ddc1eb7xa59a7c16c452f7a2@mail.gmail.com>
	<20100125133308.GA26799@desktop>
	<20100125115814.156d401d.akpm@linux-foundation.org>
	<20100125200004.GF22481@n2100.arm.linux.org.uk>
	<20100127215959.GC15325@Chamillionaire.breakpoint.cc>
Message-ID: <20100127141208.dd8244a7.akpm@linux-foundation.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 27 Jan 2010 22:59:59 +0100
Sebastian Andrzej Siewior <sebastian@breakpoint.cc> wrote:

> I just wanted to query what the status of this patch is. This patch
> seems to fix a real bug which causes a test suite to fail on ARM [0].
> The test suite passes on my VIVT ARM with this patch.
> 
> [0] http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=524003

I have it queued for 2.6.33, backportable to 2.6.32.x, assuming that
nobody sees any issues with it.
