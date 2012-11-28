From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 28 Nov 2012 17:08:27 +0100
Subject: [PATCH 5/8] mmci: replace readsl/writesl with
 ioread32_rep/iowrite32_rep
In-Reply-To: <1353683310-23654-6-git-send-email-ciminaghi@gnudd.com>
References: <1353683310-23654-1-git-send-email-ciminaghi@gnudd.com>
 <1353683310-23654-6-git-send-email-ciminaghi@gnudd.com>
Message-ID: <CACRpkdaWNC0ayN4JbEq63W+KLUdYfH5SmSu8=CNucQNixvmPUw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 23, 2012 at 4:08 PM, Davide Ciminaghi <ciminaghi@gnudd.com> wrote:

> Not all the architectures have readsl/writesl,
> use the more portable ioread32_rep/iowrite32_rep functions instead.
>
> Signed-off-by: Davide Ciminaghi <ciminaghi@gnudd.com>

Can't think of anything better, put it in Russell's patch tracker when
you think you're finished with it.
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
