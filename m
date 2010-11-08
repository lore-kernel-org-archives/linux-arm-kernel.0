From: kaloz@openwrt.org (Imre Kaloz)
Date: Mon, 08 Nov 2010 12:53:13 +0100
Subject: [patch 1/1] Fix ixp4xx build failure of some modules
In-Reply-To: <20101108104355.430478108@rtp-net.org>
References: <20101108104355.430478108@rtp-net.org>
Message-ID: <op.vluomzwl2s3iss@ecaz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 08 Nov 2010 11:43:26 +0100, Arnaud Patard <arnaud.patard@rtp-net.org> wrote:

> Commit 710224fa2750cf449c02dd115548acebfdd2c86a adds dma_set_coherent_mask()
> back but doesn't export the symbol, leading to build failures of modules
> like this :
>
> ERROR: "dma_set_coherent_mask" [drivers/usb/host/ehci-hcd.ko] undefined!

<snip>

http://lists.arm.linux.org.uk/lurker/message/20101102.114433.8822afb6.en.html


Imre
