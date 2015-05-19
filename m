From: lznuaa@gmail.com (Zhi Li)
Date: Tue, 19 May 2015 16:42:03 -0500
Subject: [PATCH 1/2] ARM: imx: enable smp for i.MX7D
In-Reply-To: <20150519025758.GK1071@dragon>
References: <1431378955-991-1-git-send-email-Frank.Li@freescale.com>
 <20150519025758.GK1071@dragon>
Message-ID: <CAHrpEqR0ntR-Eh8guhEeQguTdo+NovWmXNYH-LCn851-G+q9dQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 18, 2015 at 9:57 PM, Shawn Guo <shawnguo@kernel.org> wrote:
> In the second patch, I do not see that gpc node has "fsl,imx51-src" in
> the compatible.  How does the src_base get mapped in this case?
>
> Shawn

It is in src node, not GPC node.

src node already in imx7d.dtsi.

best regards
Frank Li
