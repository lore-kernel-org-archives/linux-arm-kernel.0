From: yoshihiro.shimoda.uh@renesas.com (Yoshihiro Shimoda)
Date: Mon, 30 Jun 2014 16:58:09 +0900
Subject: [PATCH v5 1/2] ARM: shmobile: r8a7790: add internal PCI bridge
 nodes
In-Reply-To: <53AC1373.5010501@cogentembedded.com>
References: <201406242157.05973.sergei.shtylyov@cogentembedded.com>	<201406242159.55373.sergei.shtylyov@cogentembedded.com>	<53AB89B3.9020207@renesas.com>
 <CANqRtoSsx+NAz2W_utN-A2fx+=e_Ywt5eD=Tf9uGnEDvk3w-PQ@mail.gmail.com>
 <53AB9581.7090806@renesas.com> <53AC1373.5010501@cogentembedded.com>
Message-ID: <53B11891.3020003@renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

(2014/06/26 21:34), Sergei Shtylyov wrote:
> Hello.
> 
> On 06/26/2014 07:37 AM, Yoshihiro Shimoda wrote:
> 
>>>>> From: Ben Dooks <ben.dooks@codethink.co.uk>
> 
>>>>> Add device nodes for the R8A7790 internal PCI bridge devices.
> 
>>>>> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
>>>>> Reviewed-by: Ian Molton <ian.molton@codethink.co.uk>
>>>>> [Sergei: added several properties to the PCI bridge nodes]
>>>>> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> 
>>>> Thank you for the patch!
> 
>>>> I tested this patch on my lager board and a usb memory, and it works.
> 
>>>> Tested-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> 
>>> Thanks for testing. Just one quick question from my side: Which USB
>>> port did you test?
> 
>> I tested usb ch1 only...
> 
>     Note that channel #2 also should work.

Thank you for the point.
I tried to test usb ch2, and then it worked on my environment.

>>> I somehow assumed that at least the majority of the USB ports on R-Car
>>> Gen2 require a USB PHY device driver to work?
>>
>> Thank you for the point.
>> About usb ch1, a USB PHY device driver doesn't need, I think.
>> But, about ch0 and ch2, I think that they should require a USB PHY device driver.
> 
>     Only channel #0 requires the PHY driver as the default routing for USB0 is 
> to USBHS; channel #2 is routed to OHCI/EHCI by default.

I understood it.

Best regards,
Yoshihiro Shimoda

>> Best regards,
>> Yoshihiro Shimoda
> 
> WBR, Sergei
> 
