From: olof@lixom.net (Olof Johansson)
Date: Mon, 17 Oct 2016 13:48:41 -0700
Subject: [PATCH v2 2/2] arm64: dts: zx: Add clock controller nodes
In-Reply-To: <1476361881-19685-3-git-send-email-jun.nie@linaro.org>
References: <1476361881-19685-1-git-send-email-jun.nie@linaro.org>
 <1476361881-19685-3-git-send-email-jun.nie@linaro.org>
Message-ID: <20161017204841.GD3264@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 13, 2016 at 08:31:21PM +0800, Jun Nie wrote:
> Add clock controller nodes, including one top controller
> two low speed controllers and one audio controller.
> 
> Signed-off-by: Jun Nie <jun.nie@linaro.org>
> ---
>  arch/arm64/boot/dts/zte/zx296718.dtsi | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)

This isn't a fix for a bug, so please send this with your other updates for
v4.10.

Thanks,

-Olof
