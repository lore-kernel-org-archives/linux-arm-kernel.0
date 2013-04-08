From: horms@verge.net.au (Simon Horman)
Date: Mon, 8 Apr 2013 10:33:55 +0900
Subject: [PATCH 00/02] ARM: shmobile: r8a7790 Lager arch timer fixes
In-Reply-To: <20130408012318.13555.58237.sendpatchset@w520>
References: <20130408012318.13555.58237.sendpatchset@w520>
Message-ID: <20130408013354.GA13103@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 08, 2013 at 10:23:18AM +0900, Magnus Damm wrote:
> ARM: shmobile: r8a7790 Lager arch timer fixes
> 
> [PATCH 01/02] ARM: shmobile: force enable of r8a7790 arch timer 
> [PATCH 02/02] ARM: shmobile: use r8a7790 timer setup code on Lager
> 
> This mini-series contains fixes to start the arch timer on
> r8a7790 and the Lager board regardless of boot loader setting.
> 
> Signed-off-by: Magnus Damm <damm@opensource.se>
> ---
> 
>  Written against renesas-next-20130405v2 in renesas.git

Hi Magnus,

I have tested that these patches allow the lager board to boot.
Should I queue them up?
