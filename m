From: linux.amoon@gmail.com (Anand Moon)
Date: Tue, 9 Jun 2015 08:38:21 +0530
Subject: [PATCHv2 2/2] ARM: exynos_defconfig: Enable CONFIG_LEDS_PWM for
 Odroid-XU3
In-Reply-To: <55762B98.1080409@samsung.com>
References: <1433696621-4763-1-git-send-email-linux.amoon@gmail.com>
 <1433696621-4763-2-git-send-email-linux.amoon@gmail.com>
 <55762B98.1080409@samsung.com>
Message-ID: <CANAwSgTFBNDBmkWSBdkYyk9gwmz2gryedT3-5UewG7+=hRKO5A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi

On 9 June 2015 at 05:26, Krzysztof Kozlowski <k.kozlowski@samsung.com> wrote:
> On 08.06.2015 02:03, Anand Moon wrote:
>> Enable CONFIG_LEDS_PWM amd CONFIG_LEDS_TRIGGER_HEARTBEAT for
>> Odroid-XU3 board.
>
> I am a little confused.
>
> This is v2.
>
> I found version 3, a little different:
> http://www.spinics.net/lists/linux-samsung-soc/msg44406.html
> (which
>
> Where is the changelog? Which one is newer? Should we drop the v3?
> While at it, can you add information WHY do you want to enable LEDS?
>
> Best regards,
> Krzysztof
>

Look like I an doom to make mistake.
With the introduction of this
http://www.spinics.net/lists/linux-samsung-soc/msg44481.html

We need to enable CONFIG_LEDS_PWM to make it working.
So please drop the v3 patch.

-Anand Moon
