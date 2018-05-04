From: festevam@gmail.com (Fabio Estevam)
Date: Fri, 4 May 2018 12:34:29 -0300
Subject: [PATCH 3/4] ARM: dts: imx27: use lable to override osc26m clock
 setting
In-Reply-To: <1525395446-1953-4-git-send-email-shawnguo@kernel.org>
References: <1525395446-1953-1-git-send-email-shawnguo@kernel.org>
 <1525395446-1953-4-git-send-email-shawnguo@kernel.org>
Message-ID: <CAOMZO5D1Dc9hh-o81fvy8PKNx_m8gdR9yW2w5Xumse1VFHFLTQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shawn,

On Thu, May 3, 2018 at 9:57 PM, Shawn Guo <shawnguo@kernel.org> wrote:
> Instead of copying the whole node hierarchy, let's define a label for
> clock osc26m in soc dtsi and use it for overriding clock-frequency.
>
> Signed-off-by: Shawn Guo <shawnguo@kernel.org>

In the Subject: s/lable/label

Other than that the series looks good.
