From: olof@lixom.net (Olof Johansson)
Date: Mon, 8 Feb 2016 13:37:05 -0800
Subject: [PATCH] ARM: netx: remove redundant "depends on ARCH_NETX"
In-Reply-To: <1454694197-15200-1-git-send-email-yamada.masahiro@socionext.com>
References: <1454694197-15200-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <20160208213705.GF25468@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Feb 06, 2016 at 02:43:17AM +0900, Masahiro Yamada wrote:
> These options already reside inside the ARCH_NETX-dependent menu.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Thanks, applied to next/cleanup.


-Olof
