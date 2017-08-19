From: wens@csie.org (Chen-Yu Tsai)
Date: Sat, 19 Aug 2017 16:17:23 +0800
Subject: [PATCH v3 07/10] dt-bindings: add compatible string for Allwinner
 R40 CCU
In-Reply-To: <CAGb2v65174+qJTyReMH7ov0NWvp+f6YC3+ovPVZghw9tsokmZw@mail.gmail.com>
References: <20170527102308.1988-1-icenowy@aosc.io>
 <20170527102308.1988-8-icenowy@aosc.io>
 <CAGb2v65174+qJTyReMH7ov0NWvp+f6YC3+ovPVZghw9tsokmZw@mail.gmail.com>
Message-ID: <CAGb2v65CdqK1JZWwQAby5VRaLYMFYPttLcwb9XaRJ6_PMrPEjQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, May 28, 2017 at 11:09 PM, Chen-Yu Tsai <wens@csie.org> wrote:
> On Sat, May 27, 2017 at 6:23 PM, Icenowy Zheng <icenowy@aosc.io> wrote:
>> Allwinner R40 has a clock controlling unit like the ones on other
>> Allwinner SoCs after sun6i, and can also use a CCU-based driver.
>>
>> Add a compatible string for it.
>>
>> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
>> Acked-by: Rob Herring <robh@kernel.org>
>
> Reviewed-by: Chen-Yu Tsai <wens@csie.org>

Fixed the conflict and applied for 4.14. Next time please include this when you
send the driver patches.

ChenYu
