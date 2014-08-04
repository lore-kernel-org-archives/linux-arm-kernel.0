From: jsarha@ti.com (Jyri Sarha)
Date: Mon, 4 Aug 2014 13:50:04 +0300
Subject: [PATCH 1/1] clk: ti: add support for external clock provider
In-Reply-To: <1406898948-26113-2-git-send-email-t-kristo@ti.com>
References: <1406898948-26113-1-git-send-email-t-kristo@ti.com>
 <1406898948-26113-2-git-send-email-t-kristo@ti.com>
Message-ID: <53DF655C.9020409@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/01/2014 04:15 PM, Tero Kristo wrote:
> External clock provider can now be used to register external clocks under
> it. This is needed as the TI clock driver only registers clocks
> hierarchically under clock providers, and external clocks do not belong
> under any of the current ones.
>
> Signed-off-by: Tero Kristo <t-kristo@ti.com>

Tested-by: Jyri Sarha <jsahra@ti.com>
