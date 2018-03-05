From: joonas.kylmala@iki.fi (=?UTF-8?Q?Joonas_Kylm=c3=a4l=c3=a4?=)
Date: Mon, 05 Mar 2018 20:43:00 +0000
Subject: [linux-sunxi] [PATCH v3 15/16] ARM: dts: sun8i: h3: Enable HDMI
 output on H3 boards
In-Reply-To: <24923386.1anQU1Bm90@jernej-laptop>
References: <20180301213442.16677-1-jernej.skrabec@siol.net>
 <20180301213442.16677-16-jernej.skrabec@siol.net>
 <57afe052-9a8c-f63b-ee43-5bad8cd1d193@iki.fi>
 <24923386.1anQU1Bm90@jernej-laptop>
Message-ID: <7f34f281-fa61-44b4-60a0-fa4843bc27c1@iki.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Jernej ?krabec:
> I guess that would mean also including connector node (hdmi_con_in) in DTSI, 
> since it is referenced inside. However, not all boards have HDMI connector, so 
> I didn't include it in DTSI.

You're absolutely right on this. I wish there was someway to get rid of
this duplication but that's a whole different problem to discuss.

Great work by the way!

Joonas
