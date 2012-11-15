From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 15 Nov 2012 11:35:36 +0100
Subject: [PATCH 1/3] gpio: Add simple poweroff-gpio driver
In-Reply-To: <50A146E7.2040608@wwwdotorg.org>
References: <1352650891-18356-1-git-send-email-andrew@lunn.ch>
 <1352650891-18356-2-git-send-email-andrew@lunn.ch>
 <50A020C5.4070506@wwwdotorg.org> <20121112082546.GU22029@lunn.ch>
 <50A1212C.2080601@wwwdotorg.org> <20121112181947.GS24583@lunn.ch>
 <20121112184340.GA15643@lizard> <50A146E7.2040608@wwwdotorg.org>
Message-ID: <CACRpkdb=ra9NwqEneyMoM5YnOFTVQoBxPATjUN6anooXVLiCjw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 12, 2012 at 7:58 PM, Stephen Warren <swarren@wwwdotorg.org> wrote:
> On 11/12/2012 11:43 AM, Anton Vorontsov wrote:

>> Should the gpio driver fix its bindings then?.. Polarity is a quite
>> generic concept of a GPIO, and flags are there for a reason. I'd rather
>> prefer having
>
> There is no "GPIO driver" to fix; each GPIO driver has its own bindings,
> and unfortunately, some of the GPIO binding authors chose not to include
> any flags cell in the GPIO specifier (e.g. Samsung ARM SoCs IIRC, but
> there are probably more).

So can I read this something like we have been too liberal with the
GPIO DT bindings and they are now a bit messy and need to be shaped
up? I don't know how to achieve that :-(

Alerting Grant to see if he has something to add on this subject...

Yours,
Linus Walleij
