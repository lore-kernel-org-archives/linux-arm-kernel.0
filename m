From: olof@lixom.net (Olof Johansson)
Date: Fri, 21 Jun 2013 00:30:29 -0700
Subject: [PATCH v6 2/3] arm: add debug uarts for rockchip rk29xx and
 rk3xxx series
In-Reply-To: <201306210131.11224.heiko@sntech.de>
References: <201306210129.54629.heiko@sntech.de>
 <201306210131.11224.heiko@sntech.de>
Message-ID: <20130621073029.GC30076@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 21, 2013 at 01:31:10AM +0200, Heiko St?bner wrote:
> Uarts on all recent Rockchip SoCs are Synopsis DesignWare 8250 types.
> Only their addresses vary very much.
> 
> This patch adds the necessary definitions to use any of the uart ports
> for early debug purposes.
> 
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>

Acked-by: Olof Johansson <olof@lixom.net>


-Olof
