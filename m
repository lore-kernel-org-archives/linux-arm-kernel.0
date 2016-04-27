From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Wed, 27 Apr 2016 10:30:24 +0200
Subject: bug in autoloading of imx-ipuv3-crtc
In-Reply-To: <13533046.1iFyOjiAs0@anubis.ausil.us>
References: <6926808.b0joqYQPQE@anubis.ausil.us>
 <1513165.9WxCa41tI1@anubis.ausil.us>
 <20160420230317.GT29108@pengutronix.de>
 <13533046.1iFyOjiAs0@anubis.ausil.us>
Message-ID: <1461745824.4044.8.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Dennis,

Am Freitag, den 22.04.2016, 08:11 -0500 schrieb Dennis Gilmore:
[...]
> I reverted the 4 patches in that series
> 
> 407c9eba drm/imx: Remove of_node assignment from ipuv3-crtc driver probe
> 304e6be6 gpu: ipu-v3: Assign of_node of child platform devices to 
> corresponding ports
> 99ae78c3 gpu: ipu-v3: Remove reg_offset field
> c3ede03c gpu: ipu-v3: drop unused dmfc field from client platform data
> 
> and it then worked again.
> 
> Dennis

Thank you for testing this, I've sent a patch to set the dev->of_node
pointer later so that the platform modalias matching should work again.

best regards
Philipp
