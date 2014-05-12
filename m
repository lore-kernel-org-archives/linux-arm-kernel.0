From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 12 May 2014 11:22:27 +0200
Subject: [GIT PULL] Allwinner Pinctrl changes for 3.16
In-Reply-To: <20140509173156.GF7047@lukather>
References: <20140508225209.GA13610@lukather>
 <CACRpkda7QT+sGs6wY6-fbcZ3k4sXfP=rmPimfqHjbUB5vQuO5A@mail.gmail.com>
 <20140509173156.GF7047@lukather>
Message-ID: <CACRpkdae=i8C49AMJCrRe0a=4d8Y+FhkiEOv=EJ_NfakYqRvzg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 9, 2014 at 7:31 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:

> Only pinctrl/next is not going to be rebased, right?

pinctrl/devel actually.

for-next is a mixdown branch that is rebased all the time
so don't use that.

But notify me first if you're going to be pulling in that branch!
(Handshake.)

Also: why do you need it? Just as a dependence to dts files
does *not* count as a reason to cross merge these trees,
as the device tree files are meant to even be moved out of
the kernel at some point... but you may have better reasons?

Yours,
Linus Walleij
