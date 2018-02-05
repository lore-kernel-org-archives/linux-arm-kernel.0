From: shawnguo@kernel.org (Shawn Guo)
Date: Mon, 5 Feb 2018 14:12:38 +0800
Subject: [PATCH V2 1/2] ARM: dts: imx7s: add temperature monitor support
In-Reply-To: <1516954180-26029-1-git-send-email-Anson.Huang@nxp.com>
References: <1516954180-26029-1-git-send-email-Anson.Huang@nxp.com>
Message-ID: <20180205061237.GE31354@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 26, 2018 at 04:09:39PM +0800, Anson Huang wrote:
> Add i.MX7 temperature monitor support.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> Acked-by: Dong Aisheng <aisheng.dong@nxp.com>
> ---
> no changes since V1.
>  .../devicetree/bindings/thermal/imx-thermal.txt      |  5 +++--

The bindings doc should be a separate patch or part of related
imx-thermal driver patch ...

>  arch/arm/boot/dts/imx7s.dtsi                         | 20 ++++++++++++++++++++

..., and shouldn't be mixed with dts changes.

Shawn
