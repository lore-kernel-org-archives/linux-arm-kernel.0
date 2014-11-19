From: javier.martinez@collabora.co.uk (Javier Martinez Canillas)
Date: Wed, 19 Nov 2014 18:29:47 +0100
Subject: [PATCH 1/3] ARM: dts: Add SPI flash node for Peach boards
In-Reply-To: <CAD=FV=XpweHvcTsVTMBkv9g4+GxoO8WdngGhfVj0QnOwq3ASdQ@mail.gmail.com>
References: <1416246184-29071-1-git-send-email-javier.martinez@collabora.co.uk>	<1416246184-29071-2-git-send-email-javier.martinez@collabora.co.uk>	<CAD=FV=Xkei_wxa3jWb8bPvuynbSyq4o=ezjVD0+e04aOPCAM+Q@mail.gmail.com>	<546C6BD2.4020802@collabora.co.uk>
 <CAD=FV=XpweHvcTsVTMBkv9g4+GxoO8WdngGhfVj0QnOwq3ASdQ@mail.gmail.com>
Message-ID: <546CD38B.3050700@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Doug,

On 11/19/2014 06:19 PM, Doug Anderson wrote:
>>
>> I wonder how the spidev user-space interface is supposed to be used
>> when booting with Device Trees.
> 
> OK.  Please don't take my comments as a NAK on this patch.  I should
> have done the same grep myself before sending--sorry.  I just
> remembered the old conversation and looked for that instead.
>

Ok, let's see what others say. At the very least documentation about the
spidev DT binding should be added to Documentation/devicetree/bindings/
 
> If the convention is to use "spidev" like this then I guess we're OK.
> I do wish it was a little more like "i2c" myself where you could get a
> direct access interface no matter what driver was bound underneath
> (and also if no drivers were bound underneath).  ...but I could just
> be naive.  ;)
> 

+1

> -Doug
> 

Best regards,
Javier
