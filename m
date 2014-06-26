From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Thu, 26 Jun 2014 16:28:58 +0400
Subject: [PATCH v5 1/2] ARM: shmobile: r8a7790: add internal PCI bridge
 nodes
In-Reply-To: <CANqRtoSsx+NAz2W_utN-A2fx+=e_Ywt5eD=Tf9uGnEDvk3w-PQ@mail.gmail.com>
References: <201406242157.05973.sergei.shtylyov@cogentembedded.com>	<201406242159.55373.sergei.shtylyov@cogentembedded.com>	<53AB89B3.9020207@renesas.com>
 <CANqRtoSsx+NAz2W_utN-A2fx+=e_Ywt5eD=Tf9uGnEDvk3w-PQ@mail.gmail.com>
Message-ID: <53AC120A.8000905@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 06/26/2014 07:01 AM, Magnus Damm wrote:

>>> From: Ben Dooks <ben.dooks@codethink.co.uk>

>>> Add device nodes for the R8A7790 internal PCI bridge devices.

>>> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
>>> Reviewed-by: Ian Molton <ian.molton@codethink.co.uk>
>>> [Sergei: added several properties to the PCI bridge nodes]
>>> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

>> Thank you for the patch!
>> I tested this patch on my lager board and a usb memory, and it works.

>> Tested-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

> Thanks for testing. Just one quick question from my side: Which USB
> port did you test?

> I somehow assumed that at least the majority of the USB ports on R-Car
> Gen2 require a USB PHY device driver to work?

    In fact, channel #2 also works without the PHY driver as the default 
UGCTRL2 setting route USB2 pins to OHCI/EHCI.

> Cheers,
> / magnus

WBR, Sergei
