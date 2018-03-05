From: joonas.kylmala@iki.fi (=?UTF-8?Q?Joonas_Kylm=c3=a4l=c3=a4?=)
Date: Mon, 05 Mar 2018 15:27:00 +0000
Subject: [linux-sunxi] [PATCH v3 15/16] ARM: dts: sun8i: h3: Enable HDMI
 output on H3 boards
In-Reply-To: <20180301213442.16677-16-jernej.skrabec@siol.net>
References: <20180301213442.16677-1-jernej.skrabec@siol.net>
 <20180301213442.16677-16-jernej.skrabec@siol.net>
Message-ID: <57afe052-9a8c-f63b-ee43-5bad8cd1d193@iki.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Jernej Skrabec:
> +&hdmi_out {
> +	hdmi_out_con: endpoint {
> +		remote-endpoint = <&hdmi_con_in>;
> +	};
> +};

This node is added to all the DTS files you enabled HDMI on. Is it
something that could be instead put to the DTSI file?

Joonas
