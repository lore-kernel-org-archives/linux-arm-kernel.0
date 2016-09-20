From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 20 Sep 2016 23:51:40 +0200
Subject: [GIT PULL] ARM: mvebu: drivers for v4.9 (#1)
In-Reply-To: <4134529.ol6KhRYAQp@wuerfel>
References: <87a8fabikx.fsf@free-electrons.com> <4134529.ol6KhRYAQp@wuerfel>
Message-ID: <CACRpkdZCt9n6c6FKEPgX85yhgWGfcNY1HoyEFXFY-5s1eCQByA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 20, 2016 at 12:16 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Wednesday, September 14, 2016 5:35:10 PM CEST Gregory CLEMENT wrote:
>> mvebu drivers for 4.9 (part 1)
>>
>> - Add pinctrl and clk support for the Orion5x SoC mv88f5181 variant
>>
>> ----------------------------------------------------------------
>> Jamie Lentin (2):
>>       clk: mvebu: Add clk support for the orion5x SoC mv88f5181
>>       pinctrl: mvebu: orion5x: Generalise mv88f5181l support for 88f5181
>>
>>  .../devicetree/bindings/clock/mvebu-core-clock.txt |  1 +
>>  .../bindings/pinctrl/marvell,orion-pinctrl.txt     |  4 +-
>>  drivers/clk/mvebu/orion.c                          | 70 ++++++++++++++++++++++
>>  drivers/pinctrl/mvebu/pinctrl-orion.c              | 23 +++----
>>  4 files changed, 86 insertions(+), 12 deletions(-)
>
> I see this touches pinctrl and clk drivers, but none of the maintainers are
> on Cc for this pull request, nor have they provided an Ack for the patches
> according to your git log.

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
