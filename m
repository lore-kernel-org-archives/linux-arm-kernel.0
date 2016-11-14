From: rjw@rjwysocki.net (Rafael J. Wysocki)
Date: Mon, 14 Nov 2016 01:33:21 +0100
Subject: [PATCH -next] cpufreq: brcmstb-avs-cpufreq: make symbol
 brcm_avs_cpufreq_attr static
In-Reply-To: <CAGt4E5sQvRXdS+wh2jqa9jF4jxS9TxnULXwg1vJm1fwU-Gja4g@mail.gmail.com>
References: <1478791145-21137-1-git-send-email-weiyj.lk@gmail.com>
 <CAGt4E5sQvRXdS+wh2jqa9jF4jxS9TxnULXwg1vJm1fwU-Gja4g@mail.gmail.com>
Message-ID: <5120029.lrhJXGVADr@vostro.rjw.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday, November 10, 2016 02:06:16 PM Markus Mayer wrote:
> On 10 November 2016 at 07:19, Wei Yongjun <weiyj.lk@gmail.com> wrote:
> > From: Wei Yongjun <weiyongjun1@huawei.com>
> >
> > Fixes the following sparse warning:
> >
> > drivers/cpufreq/brcmstb-avs-cpufreq.c:982:18: warning:
> >  symbol 'brcm_avs_cpufreq_attr' was not declared. Should it be static?
> 
> Yes, thanks for the fix.
> 
> Acked-by: Markus Mayer <mmayer@broadcom.com>

Applied.

Thanks,
Rafael
