From: lars@metafoo.de (Lars-Peter Clausen)
Date: Tue, 26 Nov 2013 21:27:22 +0100
Subject: [alsa-devel] KNOT / CONTINUOUS
In-Reply-To: <5294F85C.4000105@metafoo.de>
References: <20131126104140.16e3eb87@armhf> <s5h8uwba2gv.wl%tiwai@suse.de>
 <20131126200916.47a45929@armhf> <5294F85C.4000105@metafoo.de>
Message-ID: <5295042A.1000302@metafoo.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[...]
> In your codec driver you should specify the minimum and maximum supported
> rate by calling snd_pcm_hw_constraint_minmax() in the DAI startup callback.

It is also possible to set the min and max rate directly in the dai_driver
struct.
