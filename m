From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Sat, 03 Nov 2012 16:22:00 +0000
Subject: [PATCH 11/15] ARM: OMAP: timer: Interchange clksrc and clkevt
 for AM33XX
In-Reply-To: <1351859566-24818-12-git-send-email-vaibhav.bedia@ti.com>
References: <1351859566-24818-1-git-send-email-vaibhav.bedia@ti.com>
 <1351859566-24818-12-git-send-email-vaibhav.bedia@ti.com>
Message-ID: <509544A8.7010507@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/02/2012 12:32 PM, Vaibhav Bedia wrote:
> AM33XX has only one usable timer in the WKUP domain.

After reading the TRM, it seems there are two: DMTIMER0 and DMTIMER1.

Looking at the hwmod data though, I don't see a hwmod for DMTIMER0.  Can
you explain a little about why DMTIMER0 is missing/broken?

Kevin
