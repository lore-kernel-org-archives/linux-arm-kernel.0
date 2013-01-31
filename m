From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 31 Jan 2013 21:56:20 +0100
Subject: [PATCH 1/6 v14] gpio: Add a block GPIO API to gpiolib
In-Reply-To: <CAOY=C6GReEpO7ukOS8WiQgdFFAreaYK1YrZ8HQrQ9dGMFObAdQ@mail.gmail.com>
References: <1358856404-8975-1-git-send-email-stigge@antcom.de>
 <1358856404-8975-2-git-send-email-stigge@antcom.de>
 <CAOY=C6ERX=2HdvmtAW-__947_-P8r=Lvp88KzZDQdf4kAuRB5Q@mail.gmail.com>
 <51053268.2000002@antcom.de>
 <CAOY=C6GReEpO7ukOS8WiQgdFFAreaYK1YrZ8HQrQ9dGMFObAdQ@mail.gmail.com>
Message-ID: <CACRpkdaEG3UNntPGy1wnXyKahtDOWXUnqSvr-RG4ak-Ho3+AMw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 28, 2013 at 12:30 PM, Stijn Devriendt <highguy@gmail.com> wrote:

> This is one of the warts of the GPIO API, if you ask me (and probably
> others too).
> Using a resource without allocating it first is just asking for
> trouble. It's one of those
> things pinctl was designed to solve... I've been thinking about
> spending spare time
> sending out patches converting all implicit requests and then removing
> the implicit
> request, but spare time is limited...

It would be much appreciated. We can make good use of all
help we can get in this area...

Yours,
Linus Walleij
