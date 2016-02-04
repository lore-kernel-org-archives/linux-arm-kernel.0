From: vishnupatekar0510@gmail.com (Vishnu Patekar)
Date: Thu, 4 Feb 2016 16:51:06 +0800
Subject: [PATCH 06/14] ARM: dts: sun8i-a83t: Correct low speed oscillator
 clocks
In-Reply-To: <20160202131947.GS4652@lukather>
References: <1454203266-4450-1-git-send-email-vishnupatekar0510@gmail.com>
 <1454203266-4450-7-git-send-email-vishnupatekar0510@gmail.com>
 <20160202131947.GS4652@lukather>
Message-ID: <CAEzqOZvcy58T_uxvymGxuQXh_Goj3yHmgkmL4VL+x2_bycMgNg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Maxime,


On Tue, Feb 2, 2016 at 9:19 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> On Sun, Jan 31, 2016 at 09:20:58AM +0800, Vishnu Patekar wrote:
>> From: Chen-Yu Tsai <wens@csie.org>
>>
>> The A83T does not have a 32.768 kHz low speed oscillator, either as
>> an external crystal or input. It has a 16 MHz RC-based (inaccurate)
>> internal oscillator, which is then divided by 512 for a clock close
>> to 32 kHz.
>>
>> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
>
> You should have your SoB here.
>
> Is it ok to add it?
Yes, please add.
>
> Maxime
>
> --
> Maxime Ripard, Free Electrons
> Embedded Linux, Kernel and Android engineering
> http://free-electrons.com
