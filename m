From: yangyingliang@huawei.com (Yang Yingliang)
Date: Mon, 7 Sep 2015 09:49:38 +0800
Subject: [RFC PATCH v1 1/4] genirq: Introduce
 irq_settings_set_move_pcntxt() helper
In-Reply-To: <alpine.DEB.2.11.1509070007310.15006@nanos>
References: <1441513421-8092-1-git-send-email-yangyingliang@huawei.com>
 <1441513421-8092-2-git-send-email-yangyingliang@huawei.com>
 <alpine.DEB.2.11.1509070007310.15006@nanos>
Message-ID: <55ECED32.4020302@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 2015/9/7 6:08, Thomas Gleixner wrote:
> On Sun, 6 Sep 2015, Yang Yingliang wrote:
>
>> It's expected to use the helper when interrupt can be moved
>> in process.
>
> What's wrong with using the existing helper?
>
>         irq_set_status_flags(irq, IRQ_MOVE_PCNTXT);

It looks OK. I will use it next version.

Thanks,
Yang

>
> Thanks,
>
> 	tglx
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
>
