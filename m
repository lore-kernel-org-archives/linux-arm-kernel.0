From: olof@lixom.net (Olof Johansson)
Date: Thu, 13 Oct 2011 09:25:52 -0700
Subject: [PATCH] ARM: tegra: update defconfig
In-Reply-To: <74CDBE0F657A3D45AFBB94109FB122FF173BE1A063@HQMAIL01.nvidia.com>
References: <1318478219-9462-1-git-send-email-olof@lixom.net>
	<74CDBE0F657A3D45AFBB94109FB122FF173BE1A063@HQMAIL01.nvidia.com>
Message-ID: <CAOesGMgRBRwDwEALDRhO_KZzoZnWA-Eq7KhGtm+Fqnb83i+0hw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 13, 2011 at 9:03 AM, Stephen Warren <swarren@nvidia.com> wrote:
> Olof Johansson wrote at Wednesday, October 12, 2011 9:57 PM:
>> Refresh tegra_defconfig:
>>
>> New options enabled: RTC, SPI, USB and USB_STORAGE together with
>> corresponding tegra drivers. Also enable some of the common usb ethernet
>> adapters.
>>
>> Finally, enable new merged boards (Ventana) and the generic devicetree board.
>>
>> Signed-off-by: Olof Johansson <olof@lixom.net>
>
> We should also enable ASoC (sound) support. Do you want to rev the patch, or
> should I submit a patch on top of yours?

Let's keep the amount of defconfig churn down as much as possible,
since it's somewhat of a touchy subject. Please send me a patch but
I'll squash it in with mine when I apply it.


-Olof
