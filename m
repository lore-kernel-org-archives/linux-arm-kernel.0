From: olof@lixom.net (Olof Johansson)
Date: Mon, 8 Feb 2016 13:36:45 -0800
Subject: [PATCH] ARM: integrator: remove redundant select in Kconfig
In-Reply-To: <1454693920-14794-1-git-send-email-yamada.masahiro@socionext.com>
References: <1454693920-14794-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <20160208213645.GE25468@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Feb 06, 2016 at 02:38:40AM +0900, Masahiro Yamada wrote:
> All of these are already select'ed by ARCH_MULTIPLATFORM.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---

Thanks, applied to next/cleanup.


-Olof
