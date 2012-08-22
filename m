From: cjb@laptop.org (Chris Ball)
Date: Wed, 22 Aug 2012 10:02:48 -0400
Subject: [PATCH] ARM: dts: imx51-babbage: fix esdhc cd/wp properties
In-Reply-To: <1345643887-30606-1-git-send-email-shawn.guo@linaro.org> (Shawn
 Guo's message of "Wed, 22 Aug 2012 21:58:07 +0800")
References: <1345643887-30606-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <87pq6j3tyv.fsf@octavius.laptop.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

(removing stable@ from e-mail)

On Wed, Aug 22 2012, Shawn Guo wrote:
> The binding doc and dts use properties "fsl,{cd,wp}-internal" while
> esdhc driver uses "fsl,{cd,wp}-controller".  Fix binding doc and dts
> to get them match driver code.
>
> Reported-by: Chris Ball <cjb@laptop.org>
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> Cc: <stable@vger.kernel.org>
> ---
>  .../devicetree/bindings/mmc/fsl-imx-esdhc.txt      |    8 ++++----
>  arch/arm/boot/dts/imx51-babbage.dts                |    4 ++--
>  2 files changed, 6 insertions(+), 6 deletions(-)

Want to take this through your own tree, to avoid .dts conflicts later?
If so:

Acked-by: Chris Ball <cjb@laptop.org>

Thanks,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
