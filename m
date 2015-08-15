From: jianwei.wang.chn@gmail.com (Jianwei Wang)
Date: Fri, 14 Aug 2015 20:13:36 -0400
Subject: [PATCH v14 3/6] drm/panel: simple: Add support for NEC
 NL4827HC19-05B 480x272 panel
In-Reply-To: <20150813122312.GC11095@ulmo>
References: <1438158605-28248-1-git-send-email-jianwei.wang.chn@gmail.com>
 <1438158605-28248-4-git-send-email-jianwei.wang.chn@gmail.com>
 <20150813122312.GC11095@ulmo>
Message-ID: <CANk3uyBZuBOZNHqNmiRTcFAEH6BOXhD2sS=EKsY_EHfzjY406Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 13, 2015 at 8:23 AM, Thierry Reding
<thierry.reding@gmail.com> wrote:
> On Wed, Jul 29, 2015 at 04:30:02PM +0800, Jianwei Wang wrote:
>> This adds support for the NEC NL4827HC19-05B 480x272 panel to the DRM
>> simple panel driver.
>>
>> Signed-off-by: Alison Wang <b18965@freescale.com>
>> Signed-off-by: Xiubo Li <lixiubo@cmss.chinamobile.com>
>> Signed-off-by: Jianwei Wang <jianwei.wang.chn@gmail.com>
>> Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>
>> ---
>>  .../bindings/panel/nec,nl4827hc19_05b.txt          |  7 ++++++
>>  drivers/gpu/drm/panel/panel-simple.c               | 26 ++++++++++++++++++++++
>>  2 files changed, 33 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/panel/nec,nl4827hc19_05b.txt
>>
>> diff --git a/Documentation/devicetree/bindings/panel/nec,nl4827hc19_05b.txt b/Documentation/devicetree/bindings/panel/nec,nl4827hc19_05b.txt
>> new file mode 100644
>> index 0000000..20e9473
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/panel/nec,nl4827hc19_05b.txt
>> @@ -0,0 +1,7 @@
>> +NEC LCD Technologies,Ltd. WQVGA TFT LCD panel
>> +
>> +Required properties:
>> +- compatible: should be "nec,nl4827hc19_05b"
>
> Underscores are deprecated in compatible strings, so I've applied this
> with "nec,nl4827hc19-05b".
>
> Thierry

Okay, thanks.

Jianwei
