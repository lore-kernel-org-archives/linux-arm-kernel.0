From: wens@csie.org (Chen-Yu Tsai)
Date: Mon, 19 Feb 2018 11:01:19 +0800
Subject: [PATCH v3 2/7] watchdog: sunxi: allow setting timeout in
 devicetree
In-Reply-To: <20180219000619.4pjftflhcew5zav6@rob-hp-laptop>
References: <20180211200847.25000-1-marcus.folkesson@gmail.com>
 <20180211200847.25000-2-marcus.folkesson@gmail.com>
 <20180219000619.4pjftflhcew5zav6@rob-hp-laptop>
Message-ID: <CAGb2v67ei8atFKyiFXA=EZ_wPbjBt+-2e-aSRqSzS9zaxHaTKg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 19, 2018 at 8:06 AM, Rob Herring <robh@kernel.org> wrote:
> On Sun, Feb 11, 2018 at 09:08:42PM +0100, Marcus Folkesson wrote:
>> watchdog_init_timeout() will allways pick timeout_param since it
>> defaults to a valid timeout.
>>
>> By following best practice described in
>> Documentation/watchdog/watchdog-kernel-api.txt, it also
>> let us to set timout-sec property in devicetree.
>>
>> Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
>> Reviewed-by: Guenter Roeck <linux@roeck-us.net>
>> ---
>>  Documentation/devicetree/bindings/watchdog/sunxi-wdt.txt | 4 ++++
>>  drivers/watchdog/sunxi_wdt.c                             | 2 +-
>>  2 files changed, 5 insertions(+), 1 deletion(-)
>
> Reviewed-by: Rob Herring <robh@kernel.org>

Reviewed-by: Chen-Yu Tsai <wens@csie.org>
