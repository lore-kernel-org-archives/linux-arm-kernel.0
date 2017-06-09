From: wens@csie.org (Chen-Yu Tsai)
Date: Fri, 9 Jun 2017 20:24:07 +0800
Subject: [PATCH 0/3] pinctrl: sun8i: Add support for A83T R_PIO
In-Reply-To: <20170605135128.cjease7t25kjc6lp@flea.lan>
References: <20170603144427.22855-1-wens@csie.org>
 <20170605135128.cjease7t25kjc6lp@flea.lan>
Message-ID: <CAGb2v67Fs0_npNvaCFrr4bK1U5VcO-YZ9DY-Vyfk=esdQMVZuw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 5, 2017 at 9:51 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> On Sat, Jun 03, 2017 at 10:44:24PM +0800, Chen-Yu Tsai wrote:
>> Hi,
>>
>> This series adds support for the R_PIO pin controller on the A83T.
>> The pins managed this controller are mainly used for communicating
>> with the PMIC and codec, and various GPIOs for enabling power switches
>> for USB ports and WiFi.
>>
>> Patch 1 updates the sunxi pinctrl bindings.
>>
>> Patch 2 adds the pinctrl driver.
>>
>> Patch 3 adds a device node for the pin controller.
>
> Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Applied the device tree changes.

ChenYu
