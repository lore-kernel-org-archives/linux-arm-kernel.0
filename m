From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Mon, 13 Feb 2017 14:25:40 +0100
Subject: [PATCH] ARM: dts: at91: Fix matrix compatible
In-Reply-To: <1486983714-13314-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1486983714-13314-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <20170213132540.yo2z4tstsgnuhj5s@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13/02/2017 at 12:01:54 +0100, Boris Brezillon wrote:
> The matrix node was defined before the documentation for the bus
> matrix configuration was submitted. Patch the device tree to match
> the DT doc.
> 
> Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> ---
>  arch/arm/boot/dts/at91sam9261.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
Applied, thanks.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
