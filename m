From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 27 Feb 2013 21:05:37 +0000
Subject: [PATCH 00/12] ARM: mxs: move to generic DMA device tree binding
In-Reply-To: <1361978748-25281-1-git-send-email-shawn.guo@linaro.org>
References: <1361978748-25281-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <201302272105.37714.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 27 February 2013, Shawn Guo wrote:
> The series converts mxs-dma and its clients to generic DMA device tree
> binding/helper.
> 
> Subsystem maintainers,
> 
> I need your ACKs to have the series go via arm-soc as a whole if the
> patches look good to you.

Great stuff!

I have a few smaller comments (my comments on patch 4 also apply to
a lot of the other ones), but I'm very happy with the conversion
overall.

	Arnd
