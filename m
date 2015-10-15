From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Thu, 15 Oct 2015 11:23:28 +0900
Subject: linux-next: manual merge of the mfd tree with the arm-soc tree
In-Reply-To: <20151015131911.3b3a7ca8@canb.auug.org.au>
References: <20151015131911.3b3a7ca8@canb.auug.org.au>
Message-ID: <CAJKOXPdug+xtGNYReqV-THnnNF1iRW7Rh54kEWMrw22k-wNPpw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2015-10-15 11:19 GMT+09:00 Stephen Rothwell <sfr@canb.auug.org.au>:
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

Thanks! The fix for conflict is good.

Best regards,
Krzysztof
