From: balbi@ti.com (Felipe Balbi)
Date: Tue, 12 Nov 2013 08:22:06 -0600
Subject: [PATCH] ARM: dts: AM437x GP EVM support
In-Reply-To: <1384255468-2453-1-git-send-email-afzal@ti.com>
References: <1384255468-2453-1-git-send-email-afzal@ti.com>
Message-ID: <20131112142206.GD31721@saruman.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Nov 12, 2013 at 04:54:26PM +0530, Afzal Mohammed wrote:
> From: Lokesh Vutla <lokeshvutla@ti.com>
> 
> AM437x GP EVM DTS with pinmux information to make I2C on EVM usable.
> 
> Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
> Signed-off-by: Sourav Poddar <sourav.poddar@ti.com>
> Signed-off-by: Afzal Mohammed <afzal@ti.com>

could you instead send the much more complete version we already have
at [1] ? It's pointless to repatch all of that in this file if we *know*
those are already working.

[1] http://git.ti.com/cgit/cgit.cgi/ti-linux-kernel/ti-linux-kernel.git/tree/arch/arm/boot/dts/am437x-gp-evm.dts?h=ti-linux-3.12.y

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131112/b8924342/attachment.sig>
