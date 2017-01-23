From: robh@kernel.org (Rob Herring)
Date: Mon, 23 Jan 2017 10:52:08 -0600
Subject: [PATCH 10/18] ARM64: dts: meson-gxbb: Reorder nodes
In-Reply-To: <20170120222118.21476-11-afaerber@suse.de>
References: <20170120222118.21476-1-afaerber@suse.de>
 <20170120222118.21476-11-afaerber@suse.de>
Message-ID: <20170123165208.4ujwm6rjz2b3dom5@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 20, 2017 at 11:21:10PM +0100, Andreas F?rber wrote:
> Sort nodes referenced by label alphabetically.

Seems to be pointless churn.

> 
> Signed-off-by: Andreas F?rber <afaerber@suse.de>
> ---
>  arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi | 76 ++++++++++++++---------------
>  1 file changed, 38 insertions(+), 38 deletions(-)
