From: shawnguo@kernel.org (Shawn Guo)
Date: Mon, 24 Oct 2016 16:56:21 +0800
Subject: [PATCH v2 2/2] arm64: dts: zx: Add clock controller nodes
In-Reply-To: <20161017204841.GD3264@localhost>
References: <1476361881-19685-1-git-send-email-jun.nie@linaro.org>
 <1476361881-19685-3-git-send-email-jun.nie@linaro.org>
 <20161017204841.GD3264@localhost>
Message-ID: <20161024085621.GD30578@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 17, 2016 at 01:48:41PM -0700, Olof Johansson wrote:
> On Thu, Oct 13, 2016 at 08:31:21PM +0800, Jun Nie wrote:
> > Add clock controller nodes, including one top controller
> > two low speed controllers and one audio controller.
> > 
> > Signed-off-by: Jun Nie <jun.nie@linaro.org>
> > ---
> >  arch/arm64/boot/dts/zte/zx296718.dtsi | 24 ++++++++++++++++++++++++
> >  1 file changed, 24 insertions(+)
> 
> This isn't a fix for a bug, so please send this with your other updates for
> v4.10.

I queued it up for 4.10.

Shawn
