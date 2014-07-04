From: festevam@gmail.com (Fabio Estevam)
Date: Fri, 4 Jul 2014 12:47:46 -0300
Subject: [PATCH] ARM: dts: imx: correct sdma compatbile for imx6sl and
 imx6sx
In-Reply-To: <20140704145500.GJ30239@dragon>
References: <1404456361-8197-1-git-send-email-shawn.guo@freescale.com>
 <CAOMZO5DWYxcXi8yRf7Toi-1CCnXgd2z+LQHWpu3yyNTiGPJarg@mail.gmail.com>
 <20140704145500.GJ30239@dragon>
Message-ID: <CAOMZO5CkFufrNTf=uG0qHxZuqf1B-=QP2UBM0R_6dk6peT+7NQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 4, 2014 at 11:55 AM, Shawn Guo <shawn.guo@freescale.com> wrote:

>> However, I still have a question: wouldn't it be better to describe
>> the compatible string as:
>> compatible = "fsl,imx6sl-sdma", "fsl,imx6q-sdma", "fsl,imx35-sdma"; ?
>
> No, it wouldn't be better or necessary.

I have some trouble understanding when/if the three elements need to
be passed into the compatible string.

For example: on mx6sl ssi node:

                ssi1: ssi at 02028000 {
                    compatible = "fsl,imx6sl-ssi",
                            "fsl,imx51-ssi",
                            "fsl,imx21-ssi";

However on mx6sx node we have:

                ssi1: ssi at 02028000 {
                    compatible = "fsl,imx6sx-ssi", "fsl,imx21-ssi";

Which one is correct? Care to explain?
