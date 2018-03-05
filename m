From: jernej.skrabec@siol.net (Jernej =?utf-8?B?xaBrcmFiZWM=?=)
Date: Mon, 05 Mar 2018 19:24:44 +0100
Subject: [linux-sunxi] [PATCH v3 15/16] ARM: dts: sun8i: h3: Enable HDMI
 output on H3 boards
In-Reply-To: <57afe052-9a8c-f63b-ee43-5bad8cd1d193@iki.fi>
References: <20180301213442.16677-1-jernej.skrabec@siol.net>
 <20180301213442.16677-16-jernej.skrabec@siol.net>
 <57afe052-9a8c-f63b-ee43-5bad8cd1d193@iki.fi>
Message-ID: <24923386.1anQU1Bm90@jernej-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

Dne ponedeljek, 05. marec 2018 ob 16:27:00 CET je Joonas Kylm?l? napisal(a):
> Jernej Skrabec:
> > +&hdmi_out {
> > +	hdmi_out_con: endpoint {
> > +		remote-endpoint = <&hdmi_con_in>;
> > +	};
> > +};
> 
> This node is added to all the DTS files you enabled HDMI on. Is it
> something that could be instead put to the DTSI file?

I guess that would mean also including connector node (hdmi_con_in) in DTSI, 
since it is referenced inside. However, not all boards have HDMI connector, so 
I didn't include it in DTSI.

Best regards,
Jernej
