From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 23 May 2018 10:40:48 +0200
Subject: [PATCH v2 5/5] MAINTAINERS: Add Actions Semi S900 pinctrl entries
In-Reply-To: <20180520051736.4842-6-manivannan.sadhasivam@linaro.org>
References: <20180520051736.4842-1-manivannan.sadhasivam@linaro.org>
 <20180520051736.4842-6-manivannan.sadhasivam@linaro.org>
Message-ID: <CACRpkdYF7a-uwye0uwn-pT9Bprj74q1-Pcbq4WLyiE+kYY4j7w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, May 20, 2018 at 7:17 AM, Manivannan Sadhasivam
<manivannan.sadhasivam@linaro.org> wrote:

> Add S900 pinctrl entries under ARCH_ACTIONS
>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Patch applied tentatively so we have some maintenance entry for this.

Andreas expressed concerns about the driver earlier, so he might want it
split from the platform parts and have a separate entry for the pinctrl+GPIO
so Manivannan can maintain that part, also it makes sense to list
Manivannan as comaintainer of ARCH_ACTIONS with this in.

Andreas: how would you like to proceed?

I understand that I was a bit pushy or even rude in my last message
about the maintenance of this platform and the code structure of
the pin control driver. I am sorry if it caused any bad feelings on your
side :( social conflicts give me the creeps, I just try my best. Maybe
my best isn't always what it should be.

Yours,
Linus Walleij
