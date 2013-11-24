From: jason@lakedaemon.net (Jason Cooper)
Date: Sun, 24 Nov 2013 12:21:37 -0500
Subject: [PATCHv2] ARM: mvebu: Add DT entry for ReadyNAS Duo v2 to use
 gpio-poweroff driver
In-Reply-To: <87eh68fpqb.fsf@natisbad.org>
References: <87eh68fpqb.fsf@natisbad.org>
Message-ID: <20131124172137.GM29241@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 22, 2013 at 03:58:04PM +0100, Arnaud Ebalard wrote:
> 
> Without that fix, at the end of the shutdown process, the board is
> still powered (led glowing, fan running, ...).
> 
> Signed-off-by: Arnaud Ebalard <arno@natisbad.org>
> ---
> 
> Changes since v1:
>  - use macro instead of value for GPIO voltage level
> 
>  arch/arm/boot/dts/kirkwood-netgear_readynas_duo_v2.dts | 12 ++++++++++++
>  1 file changed, 12 insertions(+)

Applied to mvebu/dt

thx,

Jason.
