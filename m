From: wsa@the-dreams.de (Wolfram Sang)
Date: Wed, 9 Sep 2015 00:08:47 +0200
Subject: [PATCH v3 2/2] drm: bridge/dw_hdmi: add dw hdmi i2c bus adapter
 support
In-Reply-To: <20150903093910.GA4151@ulmo.nvidia.com>
References: <1440970470-7155-1-git-send-email-vladimir_zapolskiy@mentor.com>
 <CAD=FV=WvUp7xhsmXJgVzm1Awqej12hNF_QPJhrQq7z=Fa4Nnuw@mail.gmail.com>
 <20150902225008.GQ21084@n2100.arm.linux.org.uk>
 <CAD=FV=VuyQXNGt7dgF-YF7D7MDu31B-QuBdGpeC_+0b1F2=dKg@mail.gmail.com>
 <20150903091900.GX21084@n2100.arm.linux.org.uk>
 <20150903093910.GA4151@ulmo.nvidia.com>
Message-ID: <20150908220847.GA1529@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> Wolfram, do you know of any cases where adapter->dev.of_node would not
> be the same as adapter->dev.parent->of_node?

i2c-muxes, I'd say. dev.parent is the device of the parent I2C adapter,
while the devices get populated from the of_node of the muxing device.

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150909/8d6285db/attachment.sig>
