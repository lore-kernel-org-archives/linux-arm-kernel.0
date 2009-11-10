From: pavel@ucw.cz (Pavel Machek)
Date: Tue, 10 Nov 2009 08:56:34 +0100
Subject: [RFC PATCH] Add an earlyprintk debug console
In-Reply-To: <20091105123448.27637.97119.stgit@pc1117.cambridge.arm.com>
References: <20091105123448.27637.97119.stgit@pc1117.cambridge.arm.com>
Message-ID: <20091110075633.GB6157@ucw.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu 2009-11-05 12:35:12, Catalin Marinas wrote:
> This patch allows an earlyprintk console if CONFIG_DEBUG_LL is enabled,
> using the printch asm function.
> 
> The patch is based on the original work by Sascha Hauer.
> 
> Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Sascha Hauer <s.hauer@pengutronix.de>
> Cc: Uwe Kleine-K??nig <u.kleine-koenig@pengutronix.de>

Yes, please. Figuring out debug_ll means earlyprintk is non-trivial
and having to patch the code to get the output is unnice.

ACK.
								Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
