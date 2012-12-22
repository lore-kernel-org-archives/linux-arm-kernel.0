From: tony@atomide.com (Tony Lindgren)
Date: Fri, 21 Dec 2012 17:24:11 -0800
Subject: [PATCH v6 1/8] pinctrl: single: support generic pinconf
In-Reply-To: <1356083118-18857-2-git-send-email-haojian.zhuang@linaro.org>
References: <1356083118-18857-1-git-send-email-haojian.zhuang@linaro.org>
 <1356083118-18857-2-git-send-email-haojian.zhuang@linaro.org>
Message-ID: <20121222012410.GT21056@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

* Haojian Zhuang <haojian.zhuang@linaro.org> [121221 01:48]:
> Support the operation of generic pinconf. The supported config arguments
> are INPUT_SCHMITT, INPUT_SCHMITT_DISABLE, POWER_SOURCE, BIAS_DISABLE,
> BIAS_PULLUP, BIAS_PULLDOWN.

FYI, I'm getting one warning with this:

drivers/pinctrl/pinctrl-single.c: In function ?pcs_pinconf_group_get?:
drivers/pinctrl/pinctrl-single.c:580: warning: ?old? may be used uninitialized in this function

Will play with my bit-per-mux testcase and comment more
after the holidays. Also posted some suggestions trying
to unify the binding in the documentation patch.

Regards,

Tony
