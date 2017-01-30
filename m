From: olof@lixom.net (Olof Johansson)
Date: Sun, 29 Jan 2017 21:18:18 -0800
Subject: [RESEND PATCH 0/2] arm64: defconfig: enable some NAND config
 symbols
In-Reply-To: <1485741347-17363-1-git-send-email-yamada.masahiro@socionext.com>
References: <1485741347-17363-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <20170130051818.GW18943@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 30, 2017 at 10:55:45AM +0900, Masahiro Yamada wrote:
> I am resending this series to arm at kernel.org
> as requested by Olof Johansson.
> 
> No code change since the previous post.
> 
> 
> 
> Masahiro Yamada (2):
>   arm64: defconfig: enable CONFIG_MTD_BLOCK
>   arm64: defconfig: enable CONFIG_MTD_NAND and CONFIG_MTD_NAND_DENALI_DT
> 
>  arch/arm64/configs/defconfig | 3 +++
>  1 file changed, 3 insertions(+)

Applied, thanks!


-Olof
