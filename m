From: robh@kernel.org (Rob Herring)
Date: Mon, 14 Nov 2016 09:55:56 -0600
Subject: [PATCH v2 03/11] ARM: shmobile: r8a7745: basic SoC support
In-Reply-To: <1611958.qRQu5pdJd3@wasted.cogentembedded.com>
References: <2368353.xfo5beGC5E@wasted.cogentembedded.com>
 <1611958.qRQu5pdJd3@wasted.cogentembedded.com>
Message-ID: <20161114155556.4croyvedgacebukg@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Nov 05, 2016 at 12:49:55AM +0300, Sergei Shtylyov wrote:
> Add minimal support for the RZ/G1E (R8A7745) SoC.
> 
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> 
> ---
> Changes in version 2:
> - added Geert's tag;
> - refreshed the patch.
> 
>  Documentation/devicetree/bindings/arm/shmobile.txt |    2 ++
>  arch/arm/mach-shmobile/Kconfig                     |    4 ++++
>  arch/arm/mach-shmobile/setup-rcar-gen2.c           |    1 +
>  3 files changed, 7 insertions(+)

Acked-by: Rob Herring <robh@kernel.org>
