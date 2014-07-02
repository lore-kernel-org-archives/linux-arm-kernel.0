From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Wed, 2 Jul 2014 16:50:02 +0530
Subject: [PATCH v2 1/2] Documentation: Document Hisilicon hix5hd2 sata PHY
In-Reply-To: <1403687648-29082-2-git-send-email-zhangfei.gao@linaro.org>
References: <1403687648-29082-1-git-send-email-zhangfei.gao@linaro.org>
 <1403687648-29082-2-git-send-email-zhangfei.gao@linaro.org>
Message-ID: <53B3EAE2.4040101@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wednesday 25 June 2014 02:44 PM, Zhangfei Gao wrote:
> From: Jiancheng Xue <xuejiancheng@huawei.com>
> 
> Add necessary binding documentation SATA PHY on Hisilicon hix5hd2 soc.
> 
> Signed-off-by: Jiancheng Xue <xuejiancheng@huawei.com>
> Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
> ---
>  .../devicetree/bindings/phy/hix5hd2-sata-phy.txt   |   22 ++++++++++++++++++++
>  1 file changed, 22 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/hix5hd2-sata-phy.txt
> 
> diff --git a/Documentation/devicetree/bindings/phy/hix5hd2-sata-phy.txt b/Documentation/devicetree/bindings/phy/hix5hd2-sata-phy.txt
> new file mode 100644
> index 0000000..296168b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/phy/hix5hd2-sata-phy.txt

Generally we have a single file for a SoC while adding phy binding
documentation. So just make it hix5hd2-phy.txt.

Thanks
Kishon
