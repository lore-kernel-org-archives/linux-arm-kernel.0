From: robh@kernel.org (Rob Herring)
Date: Thu, 31 Dec 2015 16:29:46 -0600
Subject: [PATCH v4 1/6] clk: hisilicon: add CRG driver for hi3519 soc
In-Reply-To: <1451439832-13927-2-git-send-email-xuejiancheng@huawei.com>
References: <1451439832-13927-1-git-send-email-xuejiancheng@huawei.com>
 <1451439832-13927-2-git-send-email-xuejiancheng@huawei.com>
Message-ID: <20151231222946.GA21265@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 30, 2015 at 09:43:47AM +0800, Jiancheng Xue wrote:
> The CRG(Clock and Reset Generator) block provides clock
> and reset signals for other modules in hi3519 soc.
> 
> Signed-off-by: Jiancheng Xue <xuejiancheng@huawei.com>
> ---
>  .../devicetree/bindings/clock/hi3519-crg.txt       |  46 +++++++

For the binding:

Acked-by: Rob Herring <robh@kernel.org>
