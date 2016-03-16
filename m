From: narmstrong@baylibre.com (Neil Armstrong)
Date: Wed, 16 Mar 2016 16:00:27 +0100
Subject: [PATCH 10/17] pinctrl: Add PLX Technology OXNAS pinctrl and gpio
 driver
In-Reply-To: <CACRpkdby7XmbK2ZpwX3zy5J=yr1HRbmfWVab3K0ArcL6wd=oyA@mail.gmail.com>
References: <1457005210-18485-1-git-send-email-narmstrong@baylibre.com>
 <1457005210-18485-11-git-send-email-narmstrong@baylibre.com>
 <CACRpkdby7XmbK2ZpwX3zy5J=yr1HRbmfWVab3K0ArcL6wd=oyA@mail.gmail.com>
Message-ID: <56E9750B.2000800@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/15/2016 03:56 PM, Linus Walleij wrote:
> On Thu, Mar 3, 2016 at 12:40 PM, Neil Armstrong <narmstrong@baylibre.com> wrote:
> 
>> Add pinctrl and gprio control support to PLX Technology OXNAS SoC Family
> 
> Be a bit more verbose. Is this MIPS? ARM? How many pins does it have? Etc.
> 
>> CC: Ma Haijun <mahaijuns@gmail.com>
>> CC: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
>> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> 
> This driver has some way to go, but let's work on it!

Hi Linus,

Thanks a lot for the review.
This driver was initially forked from the at91 driver by Jean-Christophe PLAGNIOL-VILLARD, I just
cleaned it up for upstreaming, but yes it must be rewritten.

I think I'll reboot over a clean base, could you give a reference driver I should follow ?
It's a very simple HW, it should be easy.
> 
> There will be more review comments but I look forward to v2 as the first
> step, using more library functions and cutting down the code a bit!

These first comments are precious !

Could I post a v2 separately for review ?

Thanks,
Neil

> 
> Yours,
> Linus Walleij
> 
