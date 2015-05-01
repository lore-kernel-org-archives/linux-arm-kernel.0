From: lho@apm.com (Loc Ho)
Date: Fri, 1 May 2015 12:59:56 -0700
Subject: [PATCH v7 3/5] Documentation: Add documentation for the APM
 X-Gene SoC EDAC DTS binding
In-Reply-To: <CAL_JsqL7emqq=bSaWSi_0G5qSJqO+nVH_JH7VY+ynbrHhaSf_g@mail.gmail.com>
References: <1430259045-19012-1-git-send-email-lho@apm.com>
 <7128860.xHITr0VFap@wuerfel> <20150430094134.GD3488@pd.tnic>
 <10227049.9i19zDi2y3@wuerfel> <20150430130028.GF3488@pd.tnic>
 <CAPw-ZTnuyB2ne1C2-38qAxM_ANwdr9nuCYUMj=aTx7c90sVg+Q@mail.gmail.com>
 <20150430171846.GJ3488@pd.tnic>
 <CAPw-ZTksYNDE2zVD=ZjGzpKfXQN8KgW85ZnHoQ2eVmSGdSdMOw@mail.gmail.com>
 <CAL_JsqL7emqq=bSaWSi_0G5qSJqO+nVH_JH7VY+ynbrHhaSf_g@mail.gmail.com>
Message-ID: <CAPw-ZTnNEiTA-MJthY04yCrc9RdZOUFaNjzBHFV1fWzkBqRCyQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob,

>>>> I think we should first agreed on the DT binding and let's not worry
>>>> about APEI. Then, whether we have one file or multiple file. Again,
>>>> the HW consist of:
>>>>
>>>> 1. One top level interrupt and status registers
>
> For these registers, are there ECC specific functions here or just
> normal interrupt control/status bits (mask/unmask/status)? Assuming
> the later, then you should make this block an interrupt-controller.
> Then this is the interrupt-parent for the rest of the blocks.
>

This is the only item remain before I generate an patch with just the
memory controller. Most of the code that I see are actually an
interrupt controller HW. As it is just an interrupt mask and status
registers, is there an example in Linux that I can model after? Also,
I am not quite convince as to why we can't just share the interrupt
and request it by each memory controller?

-Loc
