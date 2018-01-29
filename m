From: jernej.skrabec@siol.net (Jernej =?utf-8?Q?=C5=A0krabec?=)
Date: Mon, 29 Jan 2018 11:35:27 +0100 (CET)
Subject: [linux-sunxi][PATCH] ARM: dts: sunxi: h3/h5: Add DAI node for HDMI
In-Reply-To: <20180129102227.ejmbifzjqmba3yja@flea.lan>
References: <20180129092223.12423-1-codekipper@gmail.com>
 <20180129102227.ejmbifzjqmba3yja@flea.lan>
Message-ID: <27087126.4975652.1517222127863.JavaMail.zimbra@musers.siol.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Maxime,

(previously I respond only to linux-sunxi mailing list)

>On Mon, Jan 29, 2018 at 10:22:23AM +0100, codekipper at gmail.com wrote:
>> From: Marcus Cooper <codekipper@gmail.com>
>> 
>> Add the new DAI block for I2S2 which is used for HDMI audio.
>> 
>> Signed-off-by: Marcus Cooper <codekipper@gmail.com>
>
>queued for 4.17, thanks!
>Maxime

Please note that HDMI I2S has usable 4 I2S lanes, since HDMI
supports 8 channel audio. As Marcus said, other blocks probably
support them too, they are just not wired out on pins.

Should we change compatible for HDMI?

Best regards,
Jernej
