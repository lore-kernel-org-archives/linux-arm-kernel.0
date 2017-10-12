From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Thu, 12 Oct 2017 10:01:23 +0900
Subject: [PATCH] kbuild: fix dependency of dtbs targets
In-Reply-To: <1507091240-12756-1-git-send-email-yamada.masahiro@socionext.com>
References: <1507091240-12756-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <CAK7LNAQm6RKQWzy+ZPO5u2qgH8qj1Rz9ONh3Cqe4+xnVWi8tvA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2017-10-04 13:27 GMT+09:00 Masahiro Yamada <yamada.masahiro@socionext.com>:
> The target "dtbs" should depend on "scripts" because it needs to
> build dtc.  The "prepare" target is unneeded here.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---


Applied to linux-kbuild/kbuild.

-- 
Best Regards
Masahiro Yamada
