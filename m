From: sunil.kovvuri@gmail.com (Sunil Kovvuri)
Date: Tue, 30 Sep 2014 14:41:35 +0530
Subject: [PATCH 3/6] pci,
 thunder: Add PCIe host controller devicetree bindings
In-Reply-To: <CAL_JsqK2bqsbjEf2OngL2=Xr8t0AUobb_bd43BV4t9iXY-n6KQ@mail.gmail.com>
References: <1411573068-12952-1-git-send-email-rric@kernel.org>
 <1411573068-12952-4-git-send-email-rric@kernel.org>
 <3082935.e3X4GsVUDn@wuerfel>
 <CAL_JsqK2bqsbjEf2OngL2=Xr8t0AUobb_bd43BV4t9iXY-n6KQ@mail.gmail.com>
Message-ID: <CA+sq2Cc3isZThykhCU=nzFx0BYFvmv+qCTHTuE48bjN+FdVjfA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thanks for pointing correction ROB.
Will fix it.

On Fri, Sep 26, 2014 at 11:56 PM, Rob Herring <robherring2@gmail.com> wrote:
> On Wed, Sep 24, 2014 at 11:06 AM, Arnd Bergmann <arnd@arndb.de> wrote:
>> On Wednesday 24 September 2014 17:37:45 Robert Richter wrote:
>>>
>>> +       pcie0 at 0x8480,00000000 {
>>
>> The name should be pci, not pci0.
>
> And the address should be "@848000000000". There was some confusion
> about when the comma should be used and it is only if you have things
> like PCI bus, device, function for the addressing.
>
>
>>
>>> +               compatible = "cavium,thunder-pcie";
>
> A bit too generic as many of the Cavium bindings have been.
>
> Rob
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
