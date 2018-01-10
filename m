From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 10 Jan 2018 23:02:06 +0100
Subject: [PATCH net-next 2/2 v10] net: ethernet: Add a driver for Gemini
 gigabit ethernet
In-Reply-To: <20180110.154322.2235369645563224203.davem@davemloft.net>
References: <20180109221053.927-1-linus.walleij@linaro.org>
 <20180109221053.927-2-linus.walleij@linaro.org>
 <20180110.154113.1759667248487481665.davem@davemloft.net>
 <20180110.154322.2235369645563224203.davem@davemloft.net>
Message-ID: <CACRpkdYZx2aXbnUgGsbmfWv3cLB_yfsyLpbMFQ37L-2Ji-c4ug@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 10, 2018 at 9:43 PM, David Miller <davem@davemloft.net> wrote:

> Actually I had to revert these two patches, this stuff doesn't even
> build.

Sorry about that, I did build it before sending out but I guess not on enough
architectures :(

I will iterate with the help of the zeroday build servers, my own machines
just don't suffice.

Yours,
Linus Walleij
