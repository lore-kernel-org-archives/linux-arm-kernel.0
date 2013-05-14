From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 14 May 2013 14:19:31 +0200
Subject: [RFC 18/42] drivers/pinctrl: don't check resource with
 devm_ioremap_resource
In-Reply-To: <1368173847-5661-19-git-send-email-wsa@the-dreams.de>
References: <1368173847-5661-1-git-send-email-wsa@the-dreams.de>
 <1368173847-5661-19-git-send-email-wsa@the-dreams.de>
Message-ID: <CACRpkda8gNhcqCa6Yv7J1kHHz+EhrpYGQn=h_JMNCXbbOdMt1A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 10, 2013 at 10:17 AM, Wolfram Sang <wsa@the-dreams.de> wrote:

> devm_ioremap_resource does sanity checks on the given resource. No need to
> duplicate this in the driver.
>
> Signed-off-by: Wolfram Sang <wsa@the-dreams.de>

Patch applied with Jean-Christophe's ACK.

Thanks!
Linus Walleij
