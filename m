From: pebolle@tiscali.nl (Paul Bolle)
Date: Tue, 09 Apr 2013 09:58:19 +0200
Subject: [PATCH 2/2] ARM: i.MX: remove unused ARCH_* configs
In-Reply-To: <1365490703-1852-2-git-send-email-s.hauer@pengutronix.de>
References: <1365490703-1852-1-git-send-email-s.hauer@pengutronix.de>
 <1365490703-1852-2-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1365494299.1830.149.camel@x61.thuisdomein>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2013-04-09 at 08:58 +0200, Sascha Hauer wrote:
> This removes the unused Kconfig options ARCH_MX5, ARCH_MX51,
> ARCH_MX53 and MACH_MX21.

I see you added MACH_MX21 too. It recently popped in my treewide
searches and is indeed unused. Thanks!


Paul Bolle
