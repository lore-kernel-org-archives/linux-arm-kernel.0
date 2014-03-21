From: zhangfei.gao@gmail.com (Zhangfei Gao)
Date: Fri, 21 Mar 2014 21:04:00 +0800
Subject: [PATCH 1/3] Documentation: add Device tree bindings for Hisilicon
 hip04 ethernet
In-Reply-To: <53284138.9030809@cogentembedded.com>
References: <1395132017-15928-1-git-send-email-zhangfei.gao@linaro.org>
 <1395132017-15928-2-git-send-email-zhangfei.gao@linaro.org>
 <53284138.9030809@cogentembedded.com>
Message-ID: <CAMj5BkjqXow9ckfg_Z+U-TnK151px3fYP3ME8=R=Dt6+qTiUiQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Sergei

Thanks for the kind suggestion, will update.

On Tue, Mar 18, 2014 at 8:51 PM, Sergei Shtylyov
<sergei.shtylyov@cogentembedded.com> wrote:

>> diff --git a/Documentation/devicetree/bindings/net/hisilicon-hip04-net.txt
>> b/Documentation/devicetree/bindings/net/hisilicon-hip04-net.txt
>> new file mode 100644
>> index 0000000..c918f08
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/net/hisilicon-hip04-net.txt
>> @@ -0,0 +1,74 @@
>> +Hisilicon hip04 Ethernet Controller
>> +
>> +* Ethernet controller node
>> +
>> +Required properties:
>> +- compatible: should be "hisilicon,hip04-mac".
>> +- reg: address and length of the register set for the device.
>> +- interrupts: interrupt for the device.
>> +- port: ppe port number connected to the controller: range from 0 to 31.
>> +- speed: 100 (100M) or 1000 (1000M).
>
>
>    There's standard "max-speed" property for that, see
> Documentation/devicetree/bindings/net/ethernet.txt in the 'net-next.git'
> repo.
>
>
>> +Optional Properties:
>> +- phy-handle : the phandle to a PHY node
>
>
>    Please refer instead to the above mentioned file for this standard
> property -- it is already described there. See other binding files as the
> example.

Yes, Documentation/devicetree/bindings/net/ethernet.txt has defined
many useful node.
Will refer it directly.

Thanks
