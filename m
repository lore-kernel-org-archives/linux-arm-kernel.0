From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Sat, 28 May 2011 09:28:44 +0800
Subject: [RFC 1/2] ARM:Tegra: Device Tree Support: Initialize the audio
	card from the device tree.
In-Reply-To: <20110527205706.21000.34832.stgit@riker>
References: <20110527205444.21000.90209.stgit@riker>
	<20110527205706.21000.34832.stgit@riker>
Message-ID: <20110528012838.GC5971@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 27, 2011 at 01:57:13PM -0700, John Bonesio wrote:

> +	harmony_audio: audio_card {
> +		compatible = "nvidia,harmony-audio";
> +	};
> +

Since the machine driver has been renamed to tegra_wm8903 to reflect the
fact that many of the nVidia designs are simple clones of each other we
ought to be using a similar name for the device tree binding for the
driver.
