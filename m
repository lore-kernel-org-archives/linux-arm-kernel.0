From: xinliang.liu@linaro.org (Xinliang Liu)
Date: Thu, 3 Mar 2016 09:28:31 +0800
Subject: [PATCH v6 01/11] drm/hisilicon: Add device tree binding for
 hi6220 display subsystem
In-Reply-To: <20160302182952.GA1184@rob-hp-laptop>
References: <1456476028-36880-1-git-send-email-xinliang.liu@linaro.org>
 <1456476028-36880-2-git-send-email-xinliang.liu@linaro.org>
 <20160302182952.GA1184@rob-hp-laptop>
Message-ID: <CAGd==0609p0x2k3F5LEDfxs_fDFGLrvtRKmNKbp0PAQg06Sy2g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 3 March 2016 at 02:29, Rob Herring <robh@kernel.org> wrote:
> On Fri, Feb 26, 2016 at 04:40:18PM +0800, Xinliang Liu wrote:
>> Add ADE display controller binding doc.
>> Add DesignWare DSI Host Controller v1.20a binding doc.
>>
>> v6:
>> - Cleanup values part of reg and clocks properties.
>> - Change "pclk_dsi" clock name to "pclk".
>> v5:
>> - Remove endpoint unit address of dsi output port.
>> - Add "hisilicon,noc-syscon" property for ADE NOC QoS syscon.
>> - Add "resets" property for ADE reset.
>> v4:
>> - Describe more specific of clocks and ports.
>> - Fix indentation.
>> v3:
>> - Make ade as the drm master node.
>> - Use assigned-clocks to set clock rate.
>> - Use ports to connect display relavant nodes.
>> v2:
>> - Move dt binding docs to bindings/display/hisilicon directory.
>>
>> Signed-off-by: Xinliang Liu <xinliang.liu@linaro.org>
>> ---
>>  .../bindings/display/hisilicon/dw-dsi.txt          | 72 ++++++++++++++++++++++
>>  .../bindings/display/hisilicon/hisi-ade.txt        | 64 +++++++++++++++++++
>>  2 files changed, 136 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/display/hisilicon/dw-dsi.txt
>>  create mode 100644 Documentation/devicetree/bindings/display/hisilicon/hisi-ade.txt
>
> Acked-by: Rob Herring <robh@kernel.org>

Thanks :-)
-xinliang
