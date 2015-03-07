From: codekipper@gmail.com (Code Kipper)
Date: Sat, 7 Mar 2015 09:41:54 +0100
Subject: [PATCH] ARM: sun7i: dt: Add new MK808C device
In-Reply-To: <20150304203400.GR4911@lukather>
References: <1425131004-8551-1-git-send-email-codekipper@gmail.com>
 <20150303071342.GB4713@lukather>
 <CAEKpxB=-vtjMckh3ZHoy0mezE9U1EtKzmttdXRD5ZNztZvB_ag@mail.gmail.com>
 <20150304203400.GR4911@lukather>
Message-ID: <CAEKpxBnRyhD8Xiu7uTomM=z4Xm4CH8WVTYjZH73yDgYzwMqn5w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4 March 2015 at 21:34, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> On Tue, Mar 03, 2015 at 09:22:32PM +0100, Code Kipper wrote:
>> >> +
>> >> +/ {
>> >> +     model = "mk808c";
>> >> +     compatible = "mk808c", "allwinner,sun7i-a20";
>> >
>> > the compatible must be of the format "vendor,device". Please add the
>> > vendor name.
>>
>> Ahhh....I've searched high and low for a vendors name. I listed it as
>> unknown on the wiki page,
>> would 'odm' be considered valid?
>
> Not really. Another mk808c device might very well be made by some
> other odm.
>
Hi Maxime,

I documented the device here at http://linux-sunxi.org/MK808C.

> Don't your device has any brand on the case or the PCB?

There is nothing on the PCB to reference a manufacturer, the actual packaging
and case are from the earlier MK808B and mention A9. There was only a
small sticker on the side to show that the contents was a MK808C.
I guess 'unknown' isn't a valid vendor name,
>
> Maxime
BR,
CK
>
> --
> Maxime Ripard, Free Electrons
> Embedded Linux, Kernel and Android engineering
> http://free-electrons.com
