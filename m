From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 15 Oct 2015 09:04:06 +0100
Subject: linux-next: manual merge of the mfd tree with the arm-soc tree
In-Reply-To: <20151015131911.3b3a7ca8@canb.auug.org.au>
References: <20151015131911.3b3a7ca8@canb.auug.org.au>
Message-ID: <20151015080406.GL32409@x1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 15 Oct 2015, Stephen Rothwell wrote:

> Hi Lee,
> 
> Today's linux-next merge of the mfd tree got a conflict in:
> 
>   Documentation/devicetree/bindings/mfd/s2mps11.txt
> 
> between commit:
> 
>   6a4479f96543 ("dt-bindings: Document grounded ACOKB pin on S2MPS11")
> 
> from the arm-soc tree and commit:
> 
>   db96ec728d69 ("mfd: dt-bindings: Document pulled down WRSTBI pin on S2MPS1X")
> 
> from the mfd tree.
> 
> I fixed it up (see below) and can carry the fix as necessary (no action
> is required).

Yeah, I thought this might happen.

Hence: http://www.spinics.net/lists/devicetree/msg97548.html.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
