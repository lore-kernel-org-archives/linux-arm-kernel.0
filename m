From: thierry.reding@gmail.com (Thierry Reding)
Date: Mon, 7 Nov 2016 12:35:50 +0100
Subject: [PATCH V4 3/6] dt/bindings: Add bindings for Tegra GMI controller
In-Reply-To: <1478507405-13204-4-git-send-email-mirza.krak@gmail.com>
References: <1478507405-13204-1-git-send-email-mirza.krak@gmail.com>
 <1478507405-13204-4-git-send-email-mirza.krak@gmail.com>
Message-ID: <20161107113550.GC28616@ulmo.ba.sec>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 07, 2016 at 09:30:02AM +0100, Mirza Krak wrote:
> From: Mirza Krak <mirza.krak@gmail.com>
> 
> Document the devicetree bindings for the Generic Memory Interface (GMI)
> bus driver found on Tegra SOCs.
> 
> Signed-off-by: Mirza Krak <mirza.krak@gmail.com>
> Tested-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> Tested-on: Colibri T20/T30 on EvalBoard V3.x and GMI-Memory Board
> Acked-by: Rob Herring <robh@kernel.org>
> ---
> 
> Changes in v2:
> - Updated examples and some information based on comments from Jon Hunter.
> 
> Changes in v3:
> - Updates ranges description based on comments from Rob Herring
> 
> Changes in v4:
> - renamed snor-*-inv to snor-*-active-high
> 
>  .../devicetree/bindings/bus/nvidia,tegra20-gmi.txt | 132 +++++++++++++++++++++
>  1 file changed, 132 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/bus/nvidia,tegra20-gmi.txt

Applied, thanks.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161107/42611e92/attachment-0001.sig>
