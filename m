From: hgkr.klein@gmail.com (Helmut Klein)
Date: Fri, 31 Mar 2017 19:03:12 +0200
Subject: [PATCH v2,1/3] meson_uart: expose CLKID_UARTx
In-Reply-To: <1490974657.12951.5.camel@baylibre.com>
References: <20170328092545.4644-1-hgkr.klein@gmail.com>
 <20170328092545.4644-2-hgkr.klein@gmail.com>
 <1490716277.20764.6.camel@baylibre.com>
 <71489b62-78c8-7082-587e-8598dc43ca59@gmail.com>
 <1490728490.20764.8.camel@baylibre.com>
 <CAFBinCDF29+kQpedsJPqRy6fztWrj91Qi6tCno_2S6UCkhW7XQ@mail.gmail.com>
 <m2y3vn6dhk.fsf@baylibre.com> <1490974657.12951.5.camel@baylibre.com>
Message-ID: <26dd484d-f6fd-048d-7467-0fe9a1e6645b@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 31.03.2017 17:37, Jerome Brunet wrote:
> On Wed, 2017-03-29 at 13:21 -0700, Kevin Hilman wrote:
>> Martin Blumenstingl <martin.blumenstingl@googlemail.com> writes:
>>
>> [...]
>>
>>> for Helmut this would mean that instead of dropping this patch (or
>>> dropping CLKID_UART1 and CLKID_UART2 from this patch) he would rather
>>> have to *add* another patch (for meson-gxbb.dtsi and meson-gxl.dtsi)
>>> which passes the core clocks to the corresponding UART controllers
>>> (similar to the CLKID_SD_EMMC_ clocks).
>>
>> Yes, this is what I would like to see.
>>
>> If a new CLKID is exposed, I want to see the users of it at the same
>> time.
>
> Helmut,
>
> If you send another version of these patches, considering the feedback of Kevin
> and Martin, could you please change the subject of this patch to:
>
> dt-bindings: clock: gxbb: expose UART clocks
>
> Thx
> Jerome
>
i've just sent v3 of my patchset.
(i changed the subjects of most patches in the set)

Helmut

>>
>> Kevin
>
