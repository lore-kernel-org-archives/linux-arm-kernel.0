From: olof@lixom.net (Olof Johansson)
Date: Thu, 13 Aug 2015 12:12:29 +0200
Subject: [PATCH] ARM: UniPhier: drop v7_invalidate_l1 call at secondary
 entry
In-Reply-To: <1439036024-1933-1-git-send-email-yamada.masahiro@socionext.com>
References: <1439036024-1933-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <20150813101229.GQ30160@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Aug 08, 2015 at 09:13:44PM +0900, Masahiro Yamada wrote:
> This is unnecessary since commit 02b4e2756e01 ("ARM: v7 setup
> function should invalidate L1 cache").
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---

Applied, thanks.


-Olof
