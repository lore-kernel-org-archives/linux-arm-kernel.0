From: robh+dt@kernel.org (Rob Herring)
Date: Fri, 3 Jun 2016 11:17:51 -0500
Subject: [PATCH v2 7/9] ARM: bcm2835: Add devicetree for the Raspberry Pi
 3.
In-Reply-To: <1464950355.24775.143.camel@redhat.com>
References: <1464934708-24769-1-git-send-email-kraxel@redhat.com>
 <5490184.9quKRk1Imx@wuerfel> <1464943546.24775.131.camel@redhat.com>
 <3885625.kWfxlR3OJi@wuerfel> <1464950355.24775.143.camel@redhat.com>
Message-ID: <CAL_JsqL2RgTLq9R3v4LDiV6Wa7totbzJBgmzVDgUv_keoS52vA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 3, 2016 at 5:39 AM, Gerd Hoffmann <kraxel@redhat.com> wrote:
>   Hi,
>
>> I tried
>>
>> subdir-y += ../../../arm64/boot/dts/broadcom
>
> Hmm, works for me too now, probably had a typo somewhere.

What directory does the dtb end up in? Because as it was, it ended up
in arch/arm64/boot/dts/broadcom. I'm not sure all this hackery is
worth it if the dtb doesn't end up in arch/arm/boot/dts/.

> But it works for "make dtbs" only, "make dtbs_install" ignores it.

That will be fun for users to debug...

Rob
