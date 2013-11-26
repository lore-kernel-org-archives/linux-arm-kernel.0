From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 26 Nov 2013 09:49:15 +0100
Subject: [PATCH 0/6] arm: sa1100: refactor h3xxx GPIO handling
In-Reply-To: <1385048414-9812-1-git-send-email-dbaryshkov@gmail.com>
References: <1385048414-9812-1-git-send-email-dbaryshkov@gmail.com>
Message-ID: <CACRpkdbNSMGWPjFVRNBmUfL2i=LEwv7kLSbo09SM-gP0JZ3Ppg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 21, 2013 at 4:40 PM, Dmitry Eremin-Solenikov
<dbaryshkov@gmail.com> wrote:

> I have been thinking abbout h3100/h3600 and GPIO issues.Could you please
> review and test these patches. It is an attempt to cleanup and refactor GPIO
> handling not to call gpio_request at init_machine time.

Tested on the h3600 and works flawlessly!

Tested-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
