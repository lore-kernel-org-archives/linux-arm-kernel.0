From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 13 Mar 2013 17:59:49 +0100
Subject: memory leak and other oddness in pinctrl-mvebu.c
In-Reply-To: <20130310000647.GZ23237@titan.lakedaemon.net>
References: <1362758331.32099.121.camel@i7.infradead.org>
 <513AF783.6050906@gmail.com>
 <1362855725.3690.92.camel@shinybook.infradead.org>
 <20130309225333.GY23237@titan.lakedaemon.net>
 <1362872371.3690.106.camel@shinybook.infradead.org>
 <20130310000647.GZ23237@titan.lakedaemon.net>
Message-ID: <CACRpkdaN4+jM6JYP_m1xcMJ=JY345SFyU_AH6cdUoxWTdEHJ8g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Mar 10, 2013 at 1:06 AM, Jason Cooper <jason@lakedaemon.net> wrote:

> Added LinusW, Gregory and Ezequiel to the email.  Guys, can you give
> this a Tested-by before I apply (or Ack for LinusW)?

If the Marvell people are happy I'm happy. But I would like to have
some Tested-by from Sebastian or so? Also I don't quite see the
final form of this patch?

And shouldn't I rather take the final patch into the pinctrl tree?

Then there is a larger issue lurking behind this, and that is that
all platforms run their own awkward DT parse code, and that comes
from the fact that we could not agree on a common mapping.
We must think real hard if we can't atleast share some of the
parsing code here.

Yours,
Linus Walleij
