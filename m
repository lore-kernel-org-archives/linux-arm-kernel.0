From: kgene.kim@samsung.com (Kukjin Kim)
Date: Sat, 09 Mar 2013 18:15:08 +0900
Subject: [PATCH v6 01/16] clk: samsung: add common clock framework helper
 functions for Samsung platforms
References: <1361175686-19400-1-git-send-email-thomas.abraham@linaro.org>
 <201303030208.49722.heiko@sntech.de> <51333149.1060105@gmail.com>
 <2984153.Xctncej7hL@flatron>
Message-ID: <042a01ce1ca6$98912140$c9b363c0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Kukjin Kim wrote:

[...]

Thomas,

As I said, I applied this whole series into Samsung tree, following error
happens with exynos4_defconfig(non-DT) though.

drivers/clk/samsung/clk.c: In function 'samsung_clk_of_register_fixed_ext':
drivers/clk/samsung/clk.c:251:2: error: implicit declaration of function
'for_each_matching_node_and_match' [-Werror=implicit-function-declaration]
drivers/clk/samsung/clk.c:251:60: error: expected ';' before '{' token
drivers/clk/samsung/clk.c:249:6: warning: unused variable 'freq'
[-Wunused-variable]
cc1: some warnings being treated as errors
make[3]: *** [drivers/clk/samsung/clk.o] Error 1
make[2]: *** [drivers/clk/samsung] Error 2
make[2]: *** Waiting for unfinished jobs....
make[1]: *** [drivers/clk] Error 2
make[1]: *** Waiting for unfinished jobs....
make: *** [drivers] Error 2
make: *** Waiting for unfinished jobs....

I think, it's time to decide to support non-DT exynos continuously, above
compilation error can be fixed though.

Hey guys, how do you think?

- Kukjin
