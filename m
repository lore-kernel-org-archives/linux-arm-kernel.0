From: khilman@baylibre.com (Kevin Hilman)
Date: Mon, 12 Sep 2016 13:43:39 -0700
Subject: [PATCH 2/3] ARM64: dts: amlogic: Add basic support for Amlogic
 S905X
In-Reply-To: <CAOQ7t2bWLq2XP2rKx3msf=1tUfXkQuBWagun46TaKk73qXr=FQ@mail.gmail.com>
 (Carlo Caione's message of "Mon, 12 Sep 2016 19:18:10 +0200")
References: <20160903082227.30559-1-narmstrong@baylibre.com>
 <20160903082227.30559-3-narmstrong@baylibre.com>
 <7e27e8c0-bb18-40d8-10d6-3928e66815c7@suse.de>
 <CAOQ7t2bWLq2XP2rKx3msf=1tUfXkQuBWagun46TaKk73qXr=FQ@mail.gmail.com>
Message-ID: <7ha8fcq26c.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Carlo Caione <carlo@caione.org> writes:

> On Mon, Sep 12, 2016 at 6:28 PM, Andreas F?rber <afaerber@suse.de> wrote:
>
>>> +Boards with the Amlogic Meson GXL SoC shall have the following properties:
>>> +  Required root node property:
>>> +    compatible: "amlogic,meson-gxl-s905x", "amlogic,meson-gxl";
>>
>> Can we please use "amlogic,s905x", "amlogic,meson-gxl"? No need to
>> complicate the name. Also affects .dtsi and .dts below.
>
> gxl != s905x.
>
> AFAWK to the GXL family belong several different SoCs, like S905X,
> S905D, etc... (see patch 3/3)
> This is why we use meson-gxl-s905x, meson-gxl-s905d, etc...

Correct.

> We could s/meson-gxl-s905x/meson-s905x/ and
> s/meson-gxl-s905d/meson-s905d/ but I honestly prefer this way because
> we can clearly see which family the SoC belongs to (the Amlogic naming
> convention is already messy enough).
> I mean, yes it's longer, but it's for the sake of documentation IMO.

+1

Kevin
