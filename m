From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 12 Jun 2012 16:32:10 +0200
Subject: [PATCH 14/14] ARM: ux500: Move rtc-pl031 registration to Device
 Tree when enabled
In-Reply-To: <4FD6F7C6.80002@linaro.org>
References: <1339428307-3850-1-git-send-email-lee.jones@linaro.org>
 <1339428307-3850-15-git-send-email-lee.jones@linaro.org>
 <CACRpkdbJdA8rgcXX4Xc3sMrx==5jd-Scu1Xy0UKz0ot3_bbNzw@mail.gmail.com>
 <4FD6F7C6.80002@linaro.org>
Message-ID: <CACRpkdYiZkRT-XLbEBRzCBKJ+721OBVKmUF+v17seFiWxmndnw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 12, 2012 at 10:03 AM, Lee Jones <lee.jones@linaro.org> wrote:
> On 11/06/12 22:43, Linus Walleij wrote:

>> Oh this is a bug fix really, well it's in the device tree so nevermind.
>
> It is? How so?

That the device tree was declaring a compatible node for something
that never existed (stericsson,db8500-rtc) while the real node is
"arm,rtc-pl031", "arm,primecell".

Without this fix 3.4 will not have an PL031 RTC I guess?

Yours,
Linus Walleij
