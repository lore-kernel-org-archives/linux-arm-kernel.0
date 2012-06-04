From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 04 Jun 2012 11:55:39 -0600
Subject: [PATCH] ARM: dt: tegra: add Whistler device tree file
In-Reply-To: <1337295233-14575-1-git-send-email-swarren@wwwdotorg.org>
References: <1337295233-14575-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <4FCCF69B.2050609@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/17/2012 04:53 PM, Stephen Warren wrote:
> Whistler is a highly configurable Tegra evaluation and development board.
> This change adds support for the following specific configuration:
> 
> E1120 motherboard
> E1108 CPU board
> E1116 PMU board
> 
> The motherboard configuration switches are set as follows:
> SW1=0 SW2=0 SW3=5
> S1/S2/S3/S4 all on, except S3 7/8 are off.
> 
> Other combinations of daugher boards may work to varying degrees, but will
> likely require some SW adjustment.

Applied for 3.6.
