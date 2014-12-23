From: Ying.Liu@freescale.com (Liu Ying)
Date: Tue, 23 Dec 2014 17:03:41 +0800
Subject: [PATCH RFC v3 11/18] drm/bridge: Add Synopsys DesignWare MIPI
 DSI host controller driver
In-Reply-To: <1770602566.921194.1419323596151.JavaMail.open-xchange@oxbaltgw08.schlund.de>
References: <1419306399-9387-1-git-send-email-Ying.Liu@freescale.com>
 <1419306399-9387-12-git-send-email-Ying.Liu@freescale.com>
 <1770602566.921194.1419323596151.JavaMail.open-xchange@oxbaltgw08.schlund.de>
Message-ID: <54992FED.5080908@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stefan,

On 12/23/2014 04:33 PM, Stefan Wahren wrote:
> Hi Liu,
>
>> Liu Ying <Ying.Liu@freescale.com> hat am 23. Dezember 2014 um 04:46
>> geschrieben:
>>
>>
>> This patch adds Synopsys DesignWare MIPI DSI host controller driver support.
>> Currently, the driver supports the burst with sync pulses mode only.
>>
>> Signed-off-by: Liu Ying <Ying.Liu@freescale.com>
>> ---
>> v2->v3:
>> * Newly introduced in v3 to address Andy Yan's comment. This is based on
>> the i.MX MIPI DSI driver in v2. To make the Synopsys DesignWare MIPI DSI
>> host controller driver less platform-dependant, this patch places it at
>> the drm/bridge directory as a DRM bridge driver.
>>
>> .../devicetree/bindings/drm/bridge/dw_mipi_dsi.txt | 72 ++
>
> please take care of [1] and send the Documentation part as a separate patch.
> This should also apply to all the other patches from your series.

All right, I'll do that.

Thanks,
Liu Ying

>
> Thanks
>
> Stefan
>
> [1] -
> http://lxr.free-electrons.com/source/Documentation/devicetree/bindings/submitting-patches.txt
>
