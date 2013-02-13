From: tony@atomide.com (Tony Lindgren)
Date: Wed, 13 Feb 2013 15:50:31 -0800
Subject: [PATCH v8 11/12] pinctrl: single: support generic pinconf
In-Reply-To: <1360602659-4774-12-git-send-email-haojian.zhuang@linaro.org>
References: <1360602659-4774-1-git-send-email-haojian.zhuang@linaro.org>
 <1360602659-4774-12-git-send-email-haojian.zhuang@linaro.org>
Message-ID: <20130213235031.GV7144@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Haojian Zhuang <haojian.zhuang@linaro.org> [130211 09:15]:
> Support the operation of generic pinconf. The supported config arguments
> are INPUT_SCHMITT, INPUT_SCHMITT_ENABLE, DRIVE_STRENGHT, BIAS_DISABLE,
> BIAS_AUTOPULL, BIAS_PULLUP, BIAS_PULLDOWN, SLEW_RATE.

I suggest you leave out BIAS_AUTOPULL here too. And then maybe check
the naming above for better search results :) It should BIAS_PULL_UP
etc I guess?

Other than that this works good for me, thanks for all the effort!

Acked-by: Tony Lindgren <tony@atomide.com>
