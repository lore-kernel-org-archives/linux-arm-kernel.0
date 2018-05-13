From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 14 May 2018 00:01:31 +0200
Subject: [RFC PATCH] driver core: make deferring probe forever optional
In-Reply-To: <91dad272-e07d-2ab6-2afa-538294e9cefa@suse.de>
References: <20180501213114.20183-1-robh@kernel.org>
 <20180507183106.GF2259@tuxbook-pro>
 <91dad272-e07d-2ab6-2afa-538294e9cefa@suse.de>
Message-ID: <CACRpkdaYN-wKErERP_65T2NH6L-+8O_ugSgg7pXfkaLkn1A2KQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 9, 2018 at 11:44 AM, Alexander Graf <agraf@suse.de> wrote:
> On 05/07/2018 08:31 PM, Bjorn Andersson wrote:

>> Can you please name platform that has enough support for Alexander to
>> care about backwards and forwards compatibility but lacks a pinctrl
>> driver.
>
> ZynqMP is one example that immediately comes to my mind. I'm sure there are
> others too.

Why isn't that using drivers/pinctrl/pinctrl-zynq.c?

How is it so very different from (old) Zynq as it is already using
the same GPIO driver?

Yours,
Linus Walleij
