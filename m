From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 16 Aug 2012 14:56:10 +0200
Subject: [PATCH] clk: convert ARM RealView to common clk
In-Reply-To: <1344270728-7550-1-git-send-email-linus.walleij@stericsson.com>
References: <1344270728-7550-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <CACRpkdaDi8KMk0tyWuEHGnLWhZ4ufnNY4cUm-+q9kKryBztzkw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 6, 2012 at 6:32 PM, Linus Walleij
<linus.walleij@stericsson.com> wrote:

> This converts the ARM RealView machine over to using the common
> clock. The approach is similar to the one used for the Integrator,
> and we're reusing the ICST wrapper code.

Mike have you had time to look at this? I got Pawel's ACK in the thread.

Yours,
Linus Walleij
