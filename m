From: jason@lakedaemon.net (Jason Cooper)
Date: Sat, 1 Nov 2014 19:06:01 -0400
Subject: [PATCH v2 2/4] watchdog: orion: Use the reference clock on
 Armada 375 SoC
In-Reply-To: <1414248522-16055-3-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1414248522-16055-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1414248522-16055-3-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <20141101230601.GH3698@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Wim,

On Sat, Oct 25, 2014 at 11:48:40AM -0300, Ezequiel Garcia wrote:
> The 25 MHz reference clock has better stability so its use is preferred over the
> core clock. Change the Armada 375 clock initialization to use this reference
> clock. To ensure the driver is compatible with an old devicetree, also provide
> a fallback path which will silently return to the previous behavior.
> 
> While here, add the clock specification to the binding documentation.
> 
> Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
> ---
>  .../devicetree/bindings/watchdog/marvel.txt        | 13 +++++++
>  drivers/watchdog/orion_wdt.c                       | 40 +++++++++++++++++++++-
>  2 files changed, 52 insertions(+), 1 deletion(-)

Acked-by: Jason Cooper <jason@lakedaemon.net>

thx,

Jason.
