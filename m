From: rtivy@ti.com (Tivy, Robert)
Date: Mon, 28 Jan 2013 23:56:10 +0000
Subject: [PATCH v6 1/2] ARM: davinci: Remoteproc driver support for
 OMAP-L138 DSP
In-Reply-To: <5103F47C.4020509@mvista.com>
References: <1359168322-17733-1-git-send-email-rtivy@ti.com>
 <1359168322-17733-2-git-send-email-rtivy@ti.com>
 <5103F47C.4020509@mvista.com>
Message-ID: <13514BD7FAEBA745BBD7D8A672905C1431206A68@DFLE08.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Sergei Shtylyov [mailto:sshtylyov at mvista.com]
> Sent: Saturday, January 26, 2013 7:22 AM
> 
> Hello.
> 
> On 26-01-2013 6:45, Robert Tivy wrote:
> 
> > Adding a remoteproc driver implementation for OMAP-L138 DSP
> 
> > diff --git a/drivers/remoteproc/da8xx_remoteproc.c
> b/drivers/remoteproc/da8xx_remoteproc.c
> > new file mode 100644
> > index 0000000..c6eb6bf
> > --- /dev/null
> > +++ b/drivers/remoteproc/da8xx_remoteproc.c
> > @@ -0,0 +1,327 @@
> [...]
> > +#define SYSCFG_CHIPSIG_OFFSET 0x174
> > +#define SYSCFG_CHIPSIG_CLR_OFFSET 0x178
> 
>     Wait, you don't even use these #define's -- why they're here at
> all?
> 
> WBR, Sergei

I will remove those.  They were inadvertently left over from when the driver was mapping SYSCFG0's base address and using those offsets to get to the CHIPSIG registers.

Regards,

- Rob
