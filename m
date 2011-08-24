From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 24 Aug 2011 09:41:31 +0200
Subject: [PATCH 1/4 v4] drivers: create a pin control subsystem
In-Reply-To: <CAGsJ_4yCAcu3uiSuDQ13ai8tmnoDkniQymp6M7DGJi84AW4mBg@mail.gmail.com>
References: <1313747630-32258-1-git-send-email-linus.walleij@stericsson.com>
	<CAGsJ_4yCAcu3uiSuDQ13ai8tmnoDkniQymp6M7DGJi84AW4mBg@mail.gmail.com>
Message-ID: <CACRpkdb=cM7fd033v_mztmKu_nSsoCHE_04cT8q1WfyArUZx4w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 24, 2011 at 8:24 AM, Barry Song <21cnbao@gmail.com> wrote:

>> +int foo_list(struct pinmux_dev *pmxdev, unsigned selector)
>
> pinctrl_dev?

Thanks Barry, fixed all instances!

Yours,
Linus Walleij
