From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Wed, 29 Jun 2016 17:58:42 +0900
Subject: [PATCH] pinctrl: uniphier: remove pointless SD pin-mux setting
 for PH1-LD11
In-Reply-To: <1467189910-14125-1-git-send-email-yamada.masahiro@socionext.com>
References: <1467189910-14125-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <CAK7LNAQYi3Na1=HwYiXXHmn6sp+22m-LVLPcGZ9LdvkfK0VyvA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2016-06-29 17:45 GMT+09:00 Masahiro Yamada <yamada.masahiro@socionext.com>:
> This SoC has no SD card controller.  This pin-muxing has no point.
>
> Fixes: 70f2f9c4cf25 ("pinctrl: uniphier: add UniPhier PH1-LD11 pinctrl driver")
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>


I found another mistake in this driver.

So, I'd like to replace this patch with the following one:
http://patchwork.ozlabs.org/patch/641896/


(Copy-paste work often ends up several mistakes...)



-- 
Best Regards
Masahiro Yamada
