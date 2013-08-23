From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 23 Aug 2013 20:06:02 +0200
Subject: [PATCH 4/4] pinctrl: mvebu: add missing iounmap
In-Reply-To: <20130822132207.GA27167@localhost>
References: <1377175611-4241-1-git-send-email-jszhang@marvell.com>
 <1377175611-4241-5-git-send-email-jszhang@marvell.com>
 <20130822132207.GA27167@localhost>
Message-ID: <CACRpkdZKGUGnnwEt0W6hQKhA0NnHWtkeBuaz-chDS=9rZD9y7A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 22, 2013 at 3:22 PM, Ezequiel Garcia
<ezequiel.garcia@free-electrons.com> wrote:
> On Thu, Aug 22, 2013 at 08:46:51PM +0800, Jisheng Zhang wrote:
>> Add missing iounmap to prove error path and remove path
>>
>> Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
>> ---
>>  drivers/pinctrl/mvebu/pinctrl-mvebu.c | 24 +++++++++++++++++-------
>>  1 file changed, 17 insertions(+), 7 deletions(-)
>
> How about using devm_ioremap_resource() instead?

Yeah that's the right solution, Jisheng can you fix this?

Yours,
Linus Walleij
