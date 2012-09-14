From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 14 Sep 2012 15:54:31 +0200
Subject: [PATCH] pinctrl: use kasprintf() in pinmux_request_gpio()
In-Reply-To: <CAMbhsRSaHOgyTn56vQndn0TKh3AT9dk3pRVuJx3qJXWowsLVaA@mail.gmail.com>
References: <1347565754-9534-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1347599944.9481.3.camel@joe2Laptop>
 <CAMbhsRSaHOgyTn56vQndn0TKh3AT9dk3pRVuJx3qJXWowsLVaA@mail.gmail.com>
Message-ID: <CACRpkdbj=tKBymnHbAmZ=Q_=UuBv+L1g3uM=k=BjjczsFxwt=g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 14, 2012 at 9:18 AM, Colin Cross <ccross@google.com> wrote:

> The one it's replacing is worse, it never sets gpiostr[15] to 0 and
> kstrdup will read past the end of the buffer if the string is
> truncated.

I recorded this as an Acked-by ... :-)

Yours,
Linus Walleij
