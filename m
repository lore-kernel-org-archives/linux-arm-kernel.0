From: olof@lixom.net (Olof Johansson)
Date: Tue, 12 Apr 2016 12:06:41 -0700
Subject: [PATCH] ARM: uniphier: drop weird sizeof()
In-Reply-To: <1458872042-30465-1-git-send-email-yamada.masahiro@socionext.com>
References: <1458872042-30465-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <20160412190641.GA4174@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 25, 2016 at 11:14:02AM +0900, Masahiro Yamada wrote:
> My intention was to ioremap a 4-byte register.  Coincidentally enough,
> sizeof(SZ_4) equals to SZ_4, but this code is weird anyway.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---

Applied to fixes, thanks.


-Olof
