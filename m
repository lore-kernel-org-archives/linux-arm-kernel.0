From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 06 Sep 2012 16:10:49 +0200
Subject: [PATCH 1/8] gpio: 74x164: Use module_spi_driver boiler plate
 function
In-Reply-To: <CACRpkdbaHK4AX8nnvu+gcsgPBYAzTNwvwKeBePxnr+GcUsa8AA@mail.gmail.com>
References: <1346834457-6257-1-git-send-email-maxime.ripard@free-electrons.com>
 <CACRpkdbaHK4AX8nnvu+gcsgPBYAzTNwvwKeBePxnr+GcUsa8AA@mail.gmail.com>
Message-ID: <5048AEE9.5030305@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

Le 06/09/2012 09:21, Linus Walleij a ?crit :
> On Wed, Sep 5, 2012 at 10:40 AM, Maxime Ripard
> <maxime.ripard@free-electrons.com> wrote:
> 
>> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
>> ---
>>  drivers/gpio/gpio-74x164.c |   13 +------------
>>  1 file changed, 1 insertion(+), 12 deletions(-)
> 
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> 
> I guess all of these will go through your kernel tree?
> Tell me if you want me to apply these to my GPIO tree.

Since I don't have any kernel tree, I guess you can apply them in your
tree :)

-- 
Maxime Ripard, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
