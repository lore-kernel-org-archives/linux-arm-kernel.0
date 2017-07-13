From: heiko@sntech.de (Heiko Stuebner)
Date: Thu, 13 Jul 2017 19:11:38 +0200
Subject: [PATCH 1/2] dt-bindings: gpu: drop wrong compatible from midgard
 binding example
In-Reply-To: <20170710121227.14264-1-heiko@sntech.de>
References: <20170710121227.14264-1-heiko@sntech.de>
Message-ID: <75024304.PTG7UsXO2n@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Montag, 10. Juli 2017, 14:12:26 CEST schrieb Heiko Stuebner:
> The binding rightfully only specifies compatibles for actual implementations
> and not for the whole family. In the example an arm,mali-midgard slipped
> through from downstream devicetrees though. So drop that to not confuse
> people reading (or copying) that example.
> 
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>

applied as fix for 4.13 with Robs Ack
