From: vkale@apm.com (Vinayak Kale)
Date: Tue, 29 Oct 2013 21:45:00 +0530
Subject: [PATCH] genirq: error reporting for non-percpu interrupt in
 request_percpu_irq()
In-Reply-To: <alpine.DEB.2.02.1310291358150.8257@ionos.tec.linutronix.de>
References: <1382090789-18177-1-git-send-email-vkale@apm.com>
 <CAPrCYke1_RjUgH79vZW99pwdExo4BspCaVi7zL-8hapKb0=gwQ@mail.gmail.com>
 <alpine.DEB.2.02.1310291358150.8257@ionos.tec.linutronix.de>
Message-ID: <CAPrCYkdtUjQAC58uhhFQpCXpA=BVQRA=_kcM+WeOht5uk9hfHQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas,

On Tue, Oct 29, 2013 at 6:29 PM, Thomas Gleixner <tglx@linutronix.de> wrote:
> On Fri, 18 Oct 2013, Vinayak Kale wrote:
>
>> Need for this patch is discussed in mail-thread [1].
>>
>> [1] http://lists.infradead.org/pipermail/linux-arm-kernel/2013-October/204414.html
>>
>
> I can't see anything which makes use of the separate error code in
> that patch.

It was suggested by Will in response to above mentioned patch.
Will's response can be found here:
http://lists.infradead.org/pipermail/linux-arm-kernel/2013-October/204491.html

Sorry for wrong link.

Thanks
-Vinayak
