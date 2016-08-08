From: icenowy@aosc.xyz (Icenowy Zheng)
Date: Mon, 08 Aug 2016 20:44:46 +0800
Subject: [PATCH 2/2] dt: bindings: Add binding for ESP8089 wifi chips
In-Reply-To: <52721384.ieJe1WiAoe@wuerfel>
References: <1470596269-20572-1-git-send-email-hdegoede@redhat.com>
 <2936779.FAiO1bqUWV@wuerfel>
 <CAGb2v67+QrOxPd4KeLb9F67A0mSaBqn14PynzCyK=ovRnKA6EQ@mail.gmail.com>
 <52721384.ieJe1WiAoe@wuerfel>
Message-ID: <276451470660286@web16j.yandex.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi,
08.08.2016, 17:30, "Arnd Bergmann" <arnd@arndb.de>:
> On Monday, August 8, 2016 11:59:25 AM CEST Chen-Yu Tsai wrote:
>> ?Hi Arnd,
>>
>> ?On Mon, Aug 8, 2016 at 3:59 AM, Arnd Bergmann <arnd@arndb.de> wrote:
>> ?> On Sunday, August 7, 2016 8:57:49 PM CEST Hans de Goede wrote:
>> ?>> +Espressif ESP8089 wireless SDIO devices
>> ?>> +
>> ?>> +This node provides properties for controlling the ESP8089 wireless device.
>> ?>> +The node is expected to be specified as a child node to the SDIO controller
>> ?>> +that connects the device to the system.
>> ?>> +
>> ?>> +Required properties:
>> ?>> +
>> ?>> + - compatible : Should be "esp,esp8089".
>> ?>
>> ?> I think it would be good to standardize a compatible string for sdio
>> ?> like we have it for other discoverable buses, based on the
>> ?> vendor/device ID (or whatever this uses), using something like
>> ?>
>> ?> compatible = "sdio1234,5678", "esp,esp8089";
>>
>> ?Is there a central repository for SDIO vendor/device IDs similar to
>> ?PCI or USB IDs?
>
> No idea. I believe the existing repositories for PCI and USB are not
> public either, there is just the information at http://pcidatabase.com/,
> http://pci-ids.ucw.cz/ or http://www.linux-usb.org/usb.ids that
> are maintained by volunteers and that are not authoritarive.
>
> I found one list at https://github.com/systemd/systemd/blob/master/hwdb/sdio.ids
> but it's probably very incomplete.
Maybe it should be maintained as a independent project...
>
>> ?The vendor ID Espressif uses is 0x6666, which seems kind of bogus to me.
>
> It probably is, but that's not important as long as nothing else uses
> that ID.
Yes... I think the USB vendor ID of Allwinner, 0x1f3a, is also nothing authoritative.
>
> ????????Arnd

Thanks,
Icenowy
