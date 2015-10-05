From: codekipper@gmail.com (Code Kipper)
Date: Mon, 5 Oct 2015 12:40:09 +0200
Subject: [PATCH v2 1/4] dt-bindings: add sunxi SPDIF transceiver bindings
In-Reply-To: <20151005084133.GE2696@lukather>
References: <1443635458-8873-1-git-send-email-codekipper@gmail.com>
 <1443635458-8873-2-git-send-email-codekipper@gmail.com>
 <20151001201215.GN7104@lukather>
 <CAEKpxB=kdmrbeiq8M=dXmpccxOhd7UZTaMkLZGo9TdRB1kMz3g@mail.gmail.com>
 <20151005084133.GE2696@lukather>
Message-ID: <CAEKpxB=FVtvepJc=35t6H9MX+xjecf=g+FLY5898W+CXKS1pDg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 5 October 2015 at 10:41, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> On Fri, Oct 02, 2015 at 07:24:20AM +0200, Code Kipper wrote:
>> >> +
>> >> +  - compatible               : should be one of the following:
>> >> +    - "allwinner,sun4i-a10-spdif": for the Allwinner A10 SoC
>> >> +    - "allwinner,sun7i-a20-spdif": for the Allwinner A20 SoC
>> >> +    - "allwinner,sun6i-a31-spdif": for the Allwinner A31 SoC
>> >
>> > Are all these compatibles really work? Is there any significant
>> > difference between the controller on all these SoCs?
>>
>> Let us assume that there isn't any difference. Remember SPDIF details
>> for all of these devices is sketchy. In the A10 User Manual, it's not
>> even mentioned although devices such as the Mele A2000 which I use
>> come with the physical connector. It's only when the A20 Manual was
>> released that we see the pin details and related components. We didn't
>> see a SPDIF block spec until the H3 User Manual was released.
>>
>> Looking at the SDK code I've only seen fifo level settings to be
>> different for the sun6i family. It was this release that also showed
>> Rx rotines. The fact of the matter is we won't know until these SoCs
>> have been tested and with that in mind I'm happy to remove all
>> capabilities for now until then.
>
> The point was more that you document compatibles that you are not
> actually supporting.
>
> You've only tested it on one SoC (and it actually works only on one
> SoC, or at least with one compatible), so only document that.

Fixed,
Thanks,
CK
>
> Maxime
>
> --
> Maxime Ripard, Free Electrons
> Embedded Linux, Kernel and Android engineering
> http://free-electrons.com
