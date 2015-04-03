From: olof@lixom.net (Olof Johansson)
Date: Fri, 3 Apr 2015 11:34:56 -0700
Subject: [PATCH 1/5] MFD/OF: document MFD devices and handle simple-mfd
In-Reply-To: <1425375148-4369-2-git-send-email-linus.walleij@linaro.org>
References: <1425375148-4369-1-git-send-email-linus.walleij@linaro.org>
 <1425375148-4369-2-git-send-email-linus.walleij@linaro.org>
Message-ID: <CAOesGMhz6WPweQFXfPhTO6Pz5L4Z1Si6YGiCRCiFD9B5qB9tVw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I understand this is bikeshedding to some extent, but I'd also like to
avoid needless variation in binding formats:

On Tue, Mar 3, 2015 at 1:32 AM, Linus Walleij <linus.walleij@linaro.org> wrote:

> +
> +foo at 1000 {
> +               compatible = "syscon", "simple-mfd";
> +               reg = <0x010000 0x1000>;
> +
> +               led at 08.0 {

This doesn't seem to be a typo, you're using a period in the unit
address. I've never seen that done before, usually commas are used
instead.

Was there a reason for going with period?


-Olof
