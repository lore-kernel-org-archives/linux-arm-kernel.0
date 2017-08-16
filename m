From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Wed, 16 Aug 2017 11:51:28 +0900
Subject: [PATCH 6/6] arm64: dts: uniphier: add Denali NAND controller nodes
In-Reply-To: <1502297011-30201-6-git-send-email-yamada.masahiro@socionext.com>
References: <1502297011-30201-1-git-send-email-yamada.masahiro@socionext.com>
 <1502297011-30201-6-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <CAK7LNARhJLakL82swMNCmEYS7ayetNA+VWtyOOvXxPZdaGu+xQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2017-08-10 1:43 GMT+09:00 Masahiro Yamada <yamada.masahiro@socionext.com>:
> Add NAND controller node to LD11 and LD20.  Neither of them supports
> the CS1 line, so pinctrl is set up for a single CS line.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---

Applied to linux-uniphier.

-- 
Best Regards
Masahiro Yamada
