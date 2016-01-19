From: robh@kernel.org (Rob Herring)
Date: Tue, 19 Jan 2016 12:13:49 -0600
Subject: [PATCH v6 5/6] ARM: dt-bindings: add device tree bindings for
 Hi3519 sysctrl
In-Reply-To: <1453171111-21921-6-git-send-email-xuejiancheng@huawei.com>
References: <1453171111-21921-1-git-send-email-xuejiancheng@huawei.com>
 <1453171111-21921-6-git-send-email-xuejiancheng@huawei.com>
Message-ID: <20160119181349.GA9747@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 19, 2016 at 10:38:30AM +0800, Jiancheng Xue wrote:
> Add device tree bindings for Hi3519 system controller.
> 
> Signed-off-by: Jiancheng Xue <xuejiancheng@huawei.com>
> ---
>  .../devicetree/bindings/arm/hisilicon/hi3519-sysctrl.txt   | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/hisilicon/hi3519-sysctrl.txt

Sorry to keep telling you different places, but I'd rather try to 
collect these in a common location (perhaps bindings/sysctrl). 
Leaving it here is fine for now. If you respin the series then please 
move it. Either way:

Acked-by: Rob Herring <robh@kernel.org>
