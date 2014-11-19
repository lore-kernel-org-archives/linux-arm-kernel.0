From: javier.martinez@collabora.co.uk (Javier Martinez Canillas)
Date: Wed, 19 Nov 2014 18:59:31 +0100
Subject: [PATCH 1/3] ARM: dts: Add SPI flash node for Peach boards
In-Reply-To: <20141119174709.GF22111@sirena.org.uk>
References: <1416246184-29071-1-git-send-email-javier.martinez@collabora.co.uk>
 <1416246184-29071-2-git-send-email-javier.martinez@collabora.co.uk>
 <CAD=FV=Xkei_wxa3jWb8bPvuynbSyq4o=ezjVD0+e04aOPCAM+Q@mail.gmail.com>
 <546C6BD2.4020802@collabora.co.uk>
 <CAD=FV=XpweHvcTsVTMBkv9g4+GxoO8WdngGhfVj0QnOwq3ASdQ@mail.gmail.com>
 <20141119174709.GF22111@sirena.org.uk>
Message-ID: <546CDA83.5060002@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Mark,

On 11/19/2014 06:47 PM, Mark Brown wrote:
> These are bugs.  The device tree should describe the hardware, spidev is
> a Linux implementation detail.  Provide a compatible string for the
> device that is there just as you would for any other device.
>

Thanks a lot for your explanation.
 
>> OK.  Please don't take my comments as a NAK on this patch.  I should
>> have done the same grep myself before sending--sorry.  I just
>> remembered the old conversation and looked for that instead.
> 
> Please take this as one.
> 

Ok

Best regards,
Javier
