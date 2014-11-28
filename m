From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 28 Nov 2014 22:38:36 +0100
Subject: [PATCH] arm64: ARM: Fix the Generic Timers interrupt active level
 description
In-Reply-To: <1417099005-18638-1-git-send-email-Liviu.Dudau@arm.com>
References: <1417099005-18638-1-git-send-email-Liviu.Dudau@arm.com>
Message-ID: <201411282238.36406.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 27 November 2014, Liviu Dudau wrote:
> The Cortex-A5x TRM states in paragraph "9.2 Generic Timer functional
> description" that generic timers provide an active-LOW interrupt
> output. Fix the device trees to correctly describe this.
> 
> While doing this update the CPU mask to match the number of described
> CPUs as well.
> 
> Signed-off-by: Liviu Dudau <Liviu.Dudau@arm.com>

Applied to next/arm64, thanks!

	Arnd
