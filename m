From: tony@atomide.com (Tony Lindgren)
Date: Wed, 13 Feb 2013 10:40:44 -0800
Subject: [PATCH v8 08/12] pinctrl: single: set function mask as optional
In-Reply-To: <1360602659-4774-9-git-send-email-haojian.zhuang@linaro.org>
References: <1360602659-4774-1-git-send-email-haojian.zhuang@linaro.org>
 <1360602659-4774-9-git-send-email-haojian.zhuang@linaro.org>
Message-ID: <20130213184044.GM7144@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Haojian Zhuang <haojian.zhuang@linaro.org> [130211 09:15]:
> Since Hisilicon's pin controller is divided into two parts. One is the
> function mux, and the other is pin configuration. These two parts are
> in the different memory regions. So make pinctrl-single,function-mask
> as optional property. Then we can define pingroups without valid
> function mux that is only used for pin configuration.

Looks OK to me:

Acked-by: Tony Lindgren <tony@atomide.com>
