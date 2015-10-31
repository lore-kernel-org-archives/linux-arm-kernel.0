From: olof@lixom.net (Olof Johansson)
Date: Sat, 31 Oct 2015 01:56:52 +0000
Subject: [PATCH] ARM: multi_v7_defconfig: enable UniPhier I2C drivers
In-Reply-To: <1445914033-4598-1-git-send-email-yamada.masahiro@socionext.com>
References: <1445914033-4598-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <20151031015652.GF1722@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 27, 2015 at 11:47:13AM +0900, Masahiro Yamada wrote:
> These two drivers were merged into the I2C sub-system by
> commit dd6fd4a32793 ("i2c: uniphier: add UniPhier FIFO-less I2C driver")
> and commit 6a62974b667f ("i2c: uniphier_f: add UniPhier FIFO-builtin I2C
> driver").
> 
> Enable them from arch/arm/configs/multi_v7_defconfig.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---

Hi,

I've added these two configs since the patch is small. We're really late and
close to the merge window so besides the other patch in this series, I can't
really pick up anything else besides fixes.


-Olof
