From: robh@kernel.org (Rob Herring)
Date: Fri, 18 Mar 2016 15:16:00 -0500
Subject: [PATCH 1/2] i2c: rk3x: add support for rk3228
In-Reply-To: <1457924955-29996-1-git-send-email-ykk@rock-chips.com>
References: <1457924955-29996-1-git-send-email-ykk@rock-chips.com>
Message-ID: <20160318201600.GA3317@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 14, 2016 at 11:09:15AM +0800, Yakir Yang wrote:
> Enable the I2C core for this SoC.
> 
> Signed-off-by: Yakir Yang <ykk@rock-chips.com>
> ---
>  Documentation/devicetree/bindings/i2c/i2c-rk3x.txt | 4 ++--
>  drivers/i2c/busses/i2c-rk3x.c                      | 1 +
>  2 files changed, 3 insertions(+), 2 deletions(-)

Acked-by: Rob Herring <robh@kernel.org>
