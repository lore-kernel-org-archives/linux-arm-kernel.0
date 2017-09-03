From: tiwai@suse.de (Takashi Iwai)
Date: Sun, 03 Sep 2017 09:19:14 +0200
Subject: [alsa-devel] [PATCH v6 02/12] ALSA: ac97: add an ac97 bus
In-Reply-To: <20170902195414.3699-3-robert.jarzmik@free.fr>
References: <20170902195414.3699-1-robert.jarzmik@free.fr>
 <20170902195414.3699-3-robert.jarzmik@free.fr>
Message-ID: <s5hwp5guu4t.wl-tiwai@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 02 Sep 2017 21:54:04 +0200,
Robert Jarzmik wrote:
> 
> AC97 is a bus for sound usage. It enables for a AC97 AC-Link to link one
> controller to 0 to 4 AC97 codecs.
> 
> The goal of this new implementation is to implement a device/driver
> model for AC97, with an automatic scan of the bus and automatic
> discovery of AC97 codec devices.
> 
> Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>

Reviewed-by: Takashi Iwai <tiwai@suse.de>


thanks,

Takashi
