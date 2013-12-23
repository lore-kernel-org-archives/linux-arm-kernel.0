From: andrew@lunn.ch (Andrew Lunn)
Date: Mon, 23 Dec 2013 16:56:18 +0100
Subject: [PATCH 1/2] ARM: Kirkwood: Add 6192 DTSI file
In-Reply-To: <1387813346-16741-1-git-send-email-maxime.hadjinlian@gmail.com>
References: <1387813346-16741-1-git-send-email-maxime.hadjinlian@gmail.com>
Message-ID: <20131223155618.GA7746@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 23, 2013 at 04:42:25PM +0100, Maxime Hadjinlian wrote:
> This file is mainly a copy of kirkwood-6281.dtsi.
> The pinctrl seems to be the same.
> These platforms differs only with their CPU, memory capabilities and the
> number of GPIO available (36 on 6192, 50 on 6281).
> 
> Signed-off-by: Maxime Hadjinlian <maxime.hadjinlian@gmail.com>
> ---
>  arch/arm/boot/dts/kirkwood-6192.dtsi | 107 +++++++++++++++++++++++++++++++++++
>  1 file changed, 107 insertions(+)
>  create mode 100644 arch/arm/boot/dts/kirkwood-6192.dtsi

Hi Maxime

Jason recently sorted both 6181 and 6182. It would be nice if this
file also used the same order. Take a look Jason's DT branch.

Thanks
     Andrew
