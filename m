From: wens@csie.org (Chen-Yu Tsai)
Date: Mon, 5 May 2014 12:20:56 +0800
Subject: [PATCH v10 15/15] ARM: dts: sun7i: Add basic support for the
 Cubietruck WiFi module
In-Reply-To: <20140505040212.GC11606@lukather>
References: <1399046249-19472-1-git-send-email-hdegoede@redhat.com>
 <1399046249-19472-16-git-send-email-hdegoede@redhat.com>
 <20140505040212.GC11606@lukather>
Message-ID: <CAGb2v65egbY5-ZeioLuoTatQ_y6iQ9n=auiiCRNAvTEj1z59hA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 5, 2014 at 12:02 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> On Fri, May 02, 2014 at 05:57:29PM +0200, Hans de Goede wrote:
>> From: Chen-Yu Tsai <wens@csie.org>
>>
>> The CubieTruck has an AMPAK AP6210 WiFi+Bluetooth module. The WiFi
>> part is a BCM43362 IC connected to MMC3 in the A20 SoC via SDIO.
>> The IC also takes a power enable signal via GPIO.
>>
>> The WiFi module supports out-of-band interrupt signaling via GPIO,
>> but this is not supported in this patch.
>>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>
> It doesn't have Chen-Yu SoB. Chen-Yu, are you fine with adding it?

My apologies, I didn't notice this patch still had my name on it.
Looks good.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
(or Acked-by, not sure which applies in this situation.)

> No need to respin the set, I'll add it when applying if it's ok.

Thanks!


Cheers,
ChenYu
