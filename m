From: andrew@lunn.ch (Andrew Lunn)
Date: Fri, 15 Dec 2017 14:01:02 +0100
Subject: [PATCH 10/25] arm: orion5x: dts: Remove leading 0x and 0s from
 bindings notation
In-Reply-To: <20171215124642.30384-1-malat@debian.org>
References: <20171215124642.30384-1-malat@debian.org>
Message-ID: <20171215130102.GF4213@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 15, 2017 at 01:46:42PM +0100, Mathieu Malaterre wrote:
> Improve the DTS files by removing all the leading "0x" and zeros to fix the

...

>  			};
>  
> -			uboot_env at 3F000 {
> +			uboot_env at 3f000 {
>  				reg = <0x3F000 0x1000>;

Hi Mathieu

Thanks for looking at this. But the commit message does not fit the
actual change.

       Andrew
