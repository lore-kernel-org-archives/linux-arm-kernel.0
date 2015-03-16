From: fabf@skynet.be (Fabian Frederick)
Date: Mon, 16 Mar 2015 21:30:32 +0100 (CET)
Subject: [PATCH 25/35 linux-next] PCI: constify of_device_id array
In-Reply-To: <55073BC0.3020009@cogentembedded.com>
References: <1426533469-25458-1-git-send-email-fabf@skynet.be>
 <1426535685-25996-1-git-send-email-fabf@skynet.be>
 <1426535685-25996-4-git-send-email-fabf@skynet.be>
 <55073BC0.3020009@cogentembedded.com>
Message-ID: <195534809.1144303.1426537832550.open-xchange@webmail.nmp.proximus.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> On 16 March 2015 at 21:23 Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> wrote:
>
>
> Hello.
>
> On 03/16/2015 10:54 PM, Fabian Frederick wrote:
>
> > of_device_id is always used as const.
> > (See driver.of_match_table and open firmware functions)
>
> > Signed-off-by: Fabian Frederick <fabf@skynet.be>
> > ---
> >? ?drivers/gpio/gpio-mpc8xxx.c? ? ? | 2 +-
> >? ?drivers/gpio/gpio-octeon.c? ? ? ?| 2 +-
> >? ?drivers/gpio/gpio-tz1090-pdc.c? ?| 2 +-
> >? ?drivers/gpio/gpio-tz1090.c? ? ? ?| 2 +-
> >? ?drivers/gpio/gpio-zynq.c? ? ? ? ?| 2 +-
>
>? ? ?What the GPIO driver changes are doing here, in the PCI patch?
Nice catch :) I'll split that patch and only send those to avoid too much noise.

Thanks,
Fabian

>
> >? ?drivers/pci/host/pci-rcar-gen2.c | 2 +-
> >? ?drivers/pci/host/pcie-xilinx.c? ?| 2 +-
> >? ?7 files changed, 7 insertions(+), 7 deletions(-)
>
> [...]
>
> WBR, Sergei
>
