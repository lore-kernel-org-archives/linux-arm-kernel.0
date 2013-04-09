From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 9 Apr 2013 11:36:09 +0200
Subject: [PATCH 4/5] dmaengine: ste_dma40: Do not configure channels
 during an channel allocation
In-Reply-To: <20130409071154.GH3084@gmail.com>
References: <1365434591-21569-1-git-send-email-lee.jones@linaro.org>
 <1365434591-21569-4-git-send-email-lee.jones@linaro.org>
 <20130409071154.GH3084@gmail.com>
Message-ID: <201304091136.09629.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 09 April 2013, Lee Jones wrote:
> According to the DMA documentation allocating a channel and configuring
> it are two separate actions. By removing the configuration code from the
> channel allocation path we lighten the burden on the information required to
> successfully allocate a channel.

Did you send out the first version again? The text is the same as before.

	Arnd
