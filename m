From: robh@kernel.org (Rob Herring)
Date: Mon, 31 Oct 2016 01:22:19 -0500
Subject: [PATCH 03/11] ARM: shmobile: r8a7745: basic SoC support
In-Reply-To: <1638480.5pJxF7pUnz@wasted.cogentembedded.com>
References: <4121805.SRTmqJtRfv@wasted.cogentembedded.com>
 <1638480.5pJxF7pUnz@wasted.cogentembedded.com>
Message-ID: <20161031062219.m5lmkwvs2yejie6r@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Oct 29, 2016 at 01:16:54AM +0300, Sergei Shtylyov wrote:
> Add minimal support for the RZ/G1E (R8A7745) SoC.
> 
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> 
> ---
>  Documentation/devicetree/bindings/arm/shmobile.txt |    2 ++

Acked-by: Rob Herring <robh@kernel.org>

>  arch/arm/mach-shmobile/Kconfig                     |    4 ++++
>  arch/arm/mach-shmobile/setup-rcar-gen2.c           |    1 +
>  3 files changed, 7 insertions(+)
