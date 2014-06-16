From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Mon, 16 Jun 2014 13:23:17 +0200
Subject: [PATCH 2/2] ARM: dts: berlin: enable i2c0 and i2c2
In-Reply-To: <1401780790-17830-3-git-send-email-antoine.tenart@free-electrons.com>
References: <1401780790-17830-1-git-send-email-antoine.tenart@free-electrons.com>
 <1401780790-17830-3-git-send-email-antoine.tenart@free-electrons.com>
Message-ID: <539ED3A5.5050300@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/03/2014 09:33 AM, Antoine T?nart wrote:
> Enable the I2C0 and I2C2 for the Marvell Berlin BG2G DMP. I2C1 and I2C3
> are also working on this board, but no devices seemed to be there.
>
> Signed-off-by: Antoine T?nart <antoine.tenart@free-electrons.com>

Applied to berlin/dt with Andrew's Reviewed-by.

Thanks!

> ---
>   arch/arm/boot/dts/berlin2q-marvell-dmp.dts | 8 ++++++++
>   1 file changed, 8 insertions(+)
>
> diff --git a/arch/arm/boot/dts/berlin2q-marvell-dmp.dts b/arch/arm/boot/dts/berlin2q-marvell-dmp.dts
> index 995150f93795..a357ce02a64e 100644
> --- a/arch/arm/boot/dts/berlin2q-marvell-dmp.dts
> +++ b/arch/arm/boot/dts/berlin2q-marvell-dmp.dts
> @@ -34,6 +34,14 @@
>   	status = "okay";
>   };
>
> +&i2c0 {
> +	status = "okay";
> +};
> +
> +&i2c2 {
> +	status = "okay";
> +};
> +
>   &uart0 {
>   	status = "okay";
>   };
>
