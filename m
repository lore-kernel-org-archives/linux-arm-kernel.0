From: robh@kernel.org (Rob Herring)
Date: Sat, 16 Jan 2016 21:43:51 -0600
Subject: [PATCH v2 12/16] ARM: Xen: Document UEFI support on Xen ARM
 virtual platforms
In-Reply-To: <1452840929-19612-13-git-send-email-zhaoshenglong@huawei.com>
References: <1452840929-19612-1-git-send-email-zhaoshenglong@huawei.com>
 <1452840929-19612-13-git-send-email-zhaoshenglong@huawei.com>
Message-ID: <20160117034351.GA16103@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 15, 2016 at 02:55:25PM +0800, Shannon Zhao wrote:
> From: Shannon Zhao <shannon.zhao@linaro.org>
> 
> Add a "uefi" node under /hypervisor node in FDT, then Linux kernel could
> scan this to get the UEFI information.
> 
> Signed-off-by: Shannon Zhao <shannon.zhao@linaro.org>
> ---
>  Documentation/devicetree/bindings/arm/xen.txt | 42 +++++++++++++++++++++++++++
>  1 file changed, 42 insertions(+)

Acked-by: Rob Herring <robh@kernel.org>
