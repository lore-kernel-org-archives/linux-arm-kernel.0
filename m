From: robh@kernel.org (Rob Herring)
Date: Wed, 15 Feb 2017 16:16:07 -0600
Subject: [PATCH v2 3/4] ARM: pwm: sun6i: add support the Allwinner A31 PWM.
In-Reply-To: <1486489846-662-4-git-send-email-lis8215@gmail.com>
References: <1486489846-662-1-git-send-email-lis8215@gmail.com>
 <1486489846-662-4-git-send-email-lis8215@gmail.com>
Message-ID: <20170215221607.ovz3vb6wihzfzoi7@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 07, 2017 at 08:50:45PM +0300, lis8215 at gmail.com wrote:
> From: Siarhei Volkau <lis8215@gmail.com>
> 
> This patch introduce the sun6i PWM driver itself:
>  - sun6i register operations,
>  - sun6i prescaler table,
>  - DT bindings for A31 SoC,
>  - documentation update.
> 
> Signed-off-by: Siarhei Volkau <lis8215@gmail.com>
> ---
>  .../devicetree/bindings/pwm/pwm-sun4i.txt          |  3 +-
>  drivers/pwm/pwm-sun4i.c                            | 71 ++++++++++++++++++++++
>  2 files changed, 73 insertions(+), 1 deletion(-)

Acked-by: Rob Herring <robh@kernel.org> 
