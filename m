From: robh@kernel.org (Rob Herring)
Date: Tue, 5 Jul 2016 10:43:04 -0500
Subject: [PATCH v3 1/3] arm64: arch_timer: Add device tree binding for
 A-008585 erratum
In-Reply-To: <1467412897-15220-1-git-send-email-oss@buserror.net>
References: <1467412897-15220-1-git-send-email-oss@buserror.net>
Message-ID: <20160705154304.GA2979@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 01, 2016 at 05:41:35PM -0500, Scott Wood wrote:
> This erratum describes a bug in logic outside the core, so MIDR can't be
> used to identify its presence, and reading an SoC-specific revision
> register from common arch timer code would be awkward.  So, describe it
> in the device tree.
> 
> Signed-off-by: Scott Wood <oss@buserror.net>
> ---
>  Documentation/devicetree/bindings/arm/arch_timer.txt | 6 ++++++
>  1 file changed, 6 insertions(+)

Acked-by: Rob Herring <robh@kernel.org>
