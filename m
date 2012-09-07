From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 7 Sep 2012 23:09:01 +0200
Subject: [PATCH 1/8] gpio: 74x164: Use module_spi_driver boiler plate
 function
In-Reply-To: <5048AEE9.5030305@free-electrons.com>
References: <1346834457-6257-1-git-send-email-maxime.ripard@free-electrons.com>
 <CACRpkdbaHK4AX8nnvu+gcsgPBYAzTNwvwKeBePxnr+GcUsa8AA@mail.gmail.com>
 <5048AEE9.5030305@free-electrons.com>
Message-ID: <CACRpkdavwww8_deiM14h0zXgdK2k8SdCZn4hfkHpmSAJuG7u7w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 6, 2012 at 4:10 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> Hi Linus,
> Le 06/09/2012 09:21, Linus Walleij a ?crit :
>>
>> Acked-by: Linus Walleij <linus.walleij@linaro.org>
>>
>> I guess all of these will go through your kernel tree?
>> Tell me if you want me to apply these to my GPIO tree.
>
> Since I don't have any kernel tree, I guess you can apply them in your
> tree :)

I was more thinking if the Free Electrons people were doing
composite pull requests to ARM SoC. Oh well, nevermind,
I'll take them.

Applied!

Linus Walleij
