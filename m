From: yoshihiro.shimoda.uh@renesas.com (Yoshihiro Shimoda)
Date: Thu, 26 Jun 2014 12:37:37 +0900
Subject: [PATCH v5 1/2] ARM: shmobile: r8a7790: add internal PCI bridge
 nodes
In-Reply-To: <CANqRtoSsx+NAz2W_utN-A2fx+=e_Ywt5eD=Tf9uGnEDvk3w-PQ@mail.gmail.com>
References: <201406242157.05973.sergei.shtylyov@cogentembedded.com>	<201406242159.55373.sergei.shtylyov@cogentembedded.com>	<53AB89B3.9020207@renesas.com>
 <CANqRtoSsx+NAz2W_utN-A2fx+=e_Ywt5eD=Tf9uGnEDvk3w-PQ@mail.gmail.com>
Message-ID: <53AB9581.7090806@renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Magnus-san,

(2014/06/26 12:01), Magnus Damm wrote:
> Hi Shimoda-san,
> 
> On Thu, Jun 26, 2014 at 11:47 AM, Yoshihiro Shimoda
> <yoshihiro.shimoda.uh@renesas.com> wrote:
>> Hi Sergei,
>>
>> (2014/06/25 2:59), Sergei Shtylyov wrote:
>>> From: Ben Dooks <ben.dooks@codethink.co.uk>
>>>
>>> Add device nodes for the R8A7790 internal PCI bridge devices.
>>>
>>> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
>>> Reviewed-by: Ian Molton <ian.molton@codethink.co.uk>
>>> [Sergei: added several properties to the PCI bridge nodes]
>>> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
>>
>> Thank you for the patch!
>> I tested this patch on my lager board and a usb memory, and it works.
>>
>> Tested-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> 
> Thanks for testing. Just one quick question from my side: Which USB
> port did you test?

I tested usb ch1 only...

> I somehow assumed that at least the majority of the USB ports on R-Car
> Gen2 require a USB PHY device driver to work?

Thank you for the point.
About usb ch1, a USB PHY device driver doesn't need, I think.
But, about ch0 and ch2, I think that they should require a USB PHY device driver.

Best regards,
Yoshihiro Shimoda

> Cheers,
> 
> / magnus
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
