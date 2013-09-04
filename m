From: andre.przywara@linaro.org (Andre Przywara)
Date: Wed, 04 Sep 2013 11:14:08 +0200
Subject: [PROPOSAL] ARM/FDT: passing multiple binaries to a kernel
In-Reply-To: <1378284955.17510.64.camel@kazak.uk.xensource.com>
References: <52260608.2030202@linaro.org>
 <CAL_JsqK9PjpScRO8561PhcyKkxhuL4pgMTCh2-UG_ubybJTcCw@mail.gmail.com>
 <5226F2B3.10606@linaro.org>
 <1378284955.17510.64.camel@kazak.uk.xensource.com>
Message-ID: <5226F9E0.9070307@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/04/2013 10:55 AM, Ian Campbell wrote:
> On Wed, 2013-09-04 at 10:43 +0200, Andre Przywara wrote:
>
>> I am about to write up a more elaborate technical rationale describing
>> the problems with multiboot on ARM:
>>
>> https://wiki.linaro.org/AndrePrzywara/Multiboot
>
> Doesn't seem to exist? A search for "mulitboot" doesn't seem to throw up
> the one you meant either.

Try again now. As mentioned "I am about to write ..." ;-)

Thanks,
Andre.

>>> So, is having a more generic solution really needed?
>>
>> Not necessarily needed, but useful, I think. As described above I don't
>> see any technical obstacles of doing it in a more generic way, so we
>> could as well go ahead with this. On x86 from time to time the need for
>> additional binaries pops up (early microcode loading, for instance), so
>> why not be be prepared.
>
> I agree. There have also been occasions where people doing
> disaggregation have wanted to start multiple initial domains, requiring
> additional modules at load time. I don't think being generic and
> extensible is costing too much here.
>
> Ian.
>
