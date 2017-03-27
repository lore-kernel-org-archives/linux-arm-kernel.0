From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 27 Mar 2017 08:05:37 +0200
Subject: [PATCH] ARM: dts: sun7i: Use axp209.dtsi on A20-OLinuXino-Micro
In-Reply-To: <20170325210533.4766-1-ezequiel@vanguardiasur.com.ar>
References: <20170325210533.4766-1-ezequiel@vanguardiasur.com.ar>
Message-ID: <20170327060537.nptabrx3gewa6tw2@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Mar 25, 2017 at 06:05:33PM -0300, Ezequiel Garcia wrote:
> This commit makes use of the axp209.dtsi file to define the
> AXP209 PMIC. While here, define the rails that are enabled on
> this board.
> 
> Tested checking the regulator voltage varies according to the
> CPU frequency.
> 
> Signed-off-by: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>

Applied, thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170327/71a3680f/attachment.sig>
