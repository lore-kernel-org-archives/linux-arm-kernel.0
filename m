From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Sat, 18 Nov 2017 13:08:27 +0900
Subject: [PATCH 2/2] kbuild: remove all dummy assignments to obj-
In-Reply-To: <1510072307-16819-3-git-send-email-yamada.masahiro@socionext.com>
References: <1510072307-16819-1-git-send-email-yamada.masahiro@socionext.com>
 <1510072307-16819-3-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <CAK7LNATMJMr-DSP=aukpbuOffBFwY-hP6a4NJenrCcivt5HmMw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2017-11-08 1:31 GMT+09:00 Masahiro Yamada <yamada.masahiro@socionext.com>:
> Now kbuild core scripts create empty built-in.o where necessary.
> Remove "obj- := dummy.o" tricks.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
>

Applied to linux-kbuild/kbuild.

-- 
Best Regards
Masahiro Yamada
