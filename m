From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Tue, 22 Aug 2017 15:20:44 +0300
Subject: [PATCH 2/2] ARM: dts: r8a7743: Add IIC cores to dtsi
In-Reply-To: <CAMuHMdXX0BRvWOc4iosiYNWuA4tP2BpLF5kndNrDL4FeKctgkA@mail.gmail.com>
References: <1502196418-31341-1-git-send-email-biju.das@bp.renesas.com>
 <12d923ba-184c-ef59-f27b-41a7592a5f93@cogentembedded.com>
 <20170810080121.GE16647@verge.net.au> <20170810112411.GA4380@katana>
 <TY1PR06MB0702EA22AFE7D8145BF623A6B7880@TY1PR06MB0702.apcprd06.prod.outlook.com>
 <CAMuHMdXX0BRvWOc4iosiYNWuA4tP2BpLF5kndNrDL4FeKctgkA@mail.gmail.com>
Message-ID: <0b7c2e3e-e620-fc47-6bca-6ec4e6b4efb2@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello!

On 08/14/2017 05:15 PM, Geert Uytterhoeven wrote:

>>> From: Wolfram Sang [mailto:wsa at the-dreams.de]
>>> Sent: 10 August 2017 12:24
>>>
>>>
>>>>>> +                i2c6: i2c at e60b0000 {
>>>>>
>>>>>     I'd use iic0 as the label.
> 
> Sergei: I assume you meant "iic3"? ;-)

    After having a look at the manual, yes. :-)

[...]

> Gr{oetje,eeting}s,
> 
>                          Geert

MBR, Sergei
