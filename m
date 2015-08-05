From: moritz.fischer@ettus.com (Moritz Fischer)
Date: Wed, 5 Aug 2015 12:43:15 -0700
Subject: [RFCv3 1/4] docs: dts: Added documentation for Xilinx Zynq Reset
 Controller bindings.
In-Reply-To: <1438701017.3793.45.camel@pengutronix.de>
References: <1438305237-18497-1-git-send-email-moritz.fischer@ettus.com>
 <1438305237-18497-2-git-send-email-moritz.fischer@ettus.com>
 <1438675772.3793.18.camel@pengutronix.de>
 <CAAtXAHeauiD5smAqMbheJWuv4BT-2YqJWOSBjYPq900icpT1Rg@mail.gmail.com>
 <1438701017.3793.45.camel@pengutronix.de>
Message-ID: <CAAtXAHfJF-5PAgCc4ZC71omc_ye6L4qa2ks2E1BdoSXxDzZu1A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Michal,

On Tue, Aug 4, 2015 at 8:10 AM, Philipp Zabel <p.zabel@pengutronix.de> wrote:
> Hi Moritz,
>
> Am Dienstag, den 04.08.2015, 08:05 -0700 schrieb Moritz Fischer:
>> Hi Philip,
>>
>> On Tue, Aug 4, 2015 at 1:09 AM, Philipp Zabel <p.zabel@pengutronix.de> wrote:
>> > Hi Moritz,
>> >
>> > Am Donnerstag, den 30.07.2015, 18:13 -0700 schrieb Moritz Fischer:
> [...]
>> >> +Required properties:
>> >> +- compatible: "xlnx,zynq-reset"
>> >> +- reg: SLCR offset and size taken via syscon <0x200 0x48>
>> >> +- syscon: <&slcr>
>> >> +  This should be a phandle to the Zynq's SLCR register.
>> >
>> >                                                  ^ register singular?
>> Do you want me to resend the entire set, or are you cool with just git
>> amending the 's' for registers?
>
> Amended and applied, thanks.

Will you take 4/4 and 2/4 via your tree?
>
> regards
> Philipp
>

Thanks,

Moritz
