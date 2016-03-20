From: robh@kernel.org (Rob Herring)
Date: Sat, 19 Mar 2016 19:45:37 -0500
Subject: [PATCH 1/3] ARM: at91: use chipid device for soc detection
In-Reply-To: <1458285681-25684-1-git-send-email-ludovic.desroches@atmel.com>
References: <1458285681-25684-1-git-send-email-ludovic.desroches@atmel.com>
Message-ID: <20160320004537.GA9151@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 18, 2016 at 08:21:19AM +0100, Ludovic Desroches wrote:
> So far, the CIDR and EXID registers were in the DBGU interface. This device
> has disappeared with the SAMA5D2 family. These registers are exposed
> through a new device called chipid.
> 
> Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
> [nicolas.ferre at atmel.com: remove useless warnings]
> ---
>  .../devicetree/bindings/arm/atmel-at91.txt         |  4 ++
>  arch/arm/mach-at91/soc.c                           | 81 +++++++++++++++++-----
>  2 files changed, 67 insertions(+), 18 deletions(-)

Acked-by: Rob Herring <robh@kernel.org>
