From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 20 Sep 2012 12:27:15 +0200
Subject: [RFC 0/6] pinctrl: samsung: Remove static platform-specific data
In-Reply-To: <1348131197-25506-1-git-send-email-t.figa@samsung.com>
References: <1348131197-25506-1-git-send-email-t.figa@samsung.com>
Message-ID: <CACRpkdYQF1+0Y=okdQPonZuHJBNy29gZyLQNzrns+CojtiyweQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 20, 2012 at 10:53 AM, Tomasz Figa <t.figa@samsung.com> wrote:

> This RFC series is a work on replacing static platform-specific data in
> pinctrl-samsung driver with data dynamically parsed from device tree.

Please include Stephen Warren on this series, he know his way
around pinctrl <-> devicetree better than anyone else.

(I'll look and see if I can see something that sticks out...)

Yours,
Linus Walleij
