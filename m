From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Wed, 02 Mar 2016 08:20:30 +0900
Subject: linux-next: manual merge of the samsung-krzk tree with the arm-soc
 tree
In-Reply-To: <20160302091450.6b1463bf@canb.auug.org.au>
References: <20160302091450.6b1463bf@canb.auug.org.au>
Message-ID: <56D623BE.3050303@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02.03.2016 07:14, Stephen Rothwell wrote:
> Hi Krzysztof,
> 
> Today's linux-next merge of the samsung-krzk tree got a conflict in:
> 
>   arch/arm64/configs/defconfig
> 
> between commit:
> 
>   efdda175c07f ("arm64: defconfig: add spmi and usb related configs")
> 
> from the arm-soc tree and commit:
> 
>   617fe7196d54 ("arm64: defconfig: Enable exynos thermal config")
>   6bb837189388 ("arm64: defconfig: Enable Samsung MFD and related configs")
> 
> from the samsung-krzk tree.
> 
> I fixed it up (see below) and can carry the fix as necessary (no action

Yeah, that was expected... Thanks for the fix, looks fine from Samsung's
side.

Best regards,
Krzysztof
