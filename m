From: graeme.gregory@linaro.org (G Gregory)
Date: Wed, 23 Sep 2015 16:45:35 +0100
Subject: [RFC 0/5] console/acpi: add DBG2 and SPCR console configuration
In-Reply-To: <CACVXFVPEJb-RXLgU0V+HduoENquUs3oDGWsUtCvH+TOSRMYiUg@mail.gmail.com>
References: <1441716217-23786-1-git-send-email-leif.lindholm@linaro.org>
 <CACVXFVPEJb-RXLgU0V+HduoENquUs3oDGWsUtCvH+TOSRMYiUg@mail.gmail.com>
Message-ID: <20150923154535.GB2431@xora-yoga13-vm.xora.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 23, 2015 at 03:38:20PM +0800, Ming Lei wrote:
> Hi Leif,
> 
> 
> On Tue, Sep 8, 2015 at 8:43 PM, Leif Lindholm <leif.lindholm@linaro.org> wrote:
> > Support for configuring bootconsole and console via the ACPI tables
> > DBG2 (Debug Port Table 2) [1] and SPCR (Serial Port Console Redirection
> > Table) [2], defined by Microsoft, has been discussed on and off over the
> > years.
> >
> > [1] https://msdn.microsoft.com/en-us/library/windows/hardware/dn639131(v=vs.85).aspx
> > [2] https://msdn.microsoft.com/en-us/library/windows/hardware/dn639132(v=vs.85).aspx
> >
> > Licensing concerns have prevented this happening in the past, but as of
> > 10 August 2015, these tables have both been released also under OWF 1.0
> > (http://www.openwebfoundation.org/legal/the-owf-1-0-agreements/owfa-1-0)
> > which is think is noncontroversially GPL-compatible?
> >
> > This set is a first attempt at implementing this.
> 
> From distribution view, the patchset looks very useful.
> 
> I have one simple question, are there other candidates for conveying this kind
> of information like what DBG2/SPCR does? Or are DBG2 and SPCR the
> offical speficiations to do such things in ARM server industry?
> 

They are mandated in the SBBR spec

Graeme
