From: shawn.guo@freescale.com (Shawn Guo)
Date: Tue, 29 Apr 2014 14:06:50 +0800
Subject: [PATCH 8/8] ARM: dts: imx27-phytec-phycore-*: Move "iomux" node
 to the bottom of file
In-Reply-To: <1398487933-5683-8-git-send-email-shc_work@mail.ru>
References: <1398487933-5683-1-git-send-email-shc_work@mail.ru>
 <1398487933-5683-8-git-send-email-shc_work@mail.ru>
Message-ID: <20140429060648.GH16451@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Apr 26, 2014 at 08:52:13AM +0400, Alexander Shiyan wrote:
> This patch moves "iomux" node to the bottom of file.

Let's only do this for new files, and save the churn on the existing
files.

Shawn

> No functional changes.
> 
> Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
> ---
>  arch/arm/boot/dts/imx27-phytec-phycore-rdk.dts  | 234 ++++++++++++------------
>  arch/arm/boot/dts/imx27-phytec-phycore-som.dtsi | 176 +++++++++---------
>  2 files changed, 205 insertions(+), 205 deletions(-)
