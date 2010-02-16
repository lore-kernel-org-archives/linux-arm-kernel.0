From: marek.vasut@gmail.com (Marek Vasut)
Date: Tue, 16 Feb 2010 03:45:36 +0100
Subject: [PATCH 1/2] PXA3xx: Add support for preconfiguring SMEMC
In-Reply-To: <f17812d71002150633p1699d012ocf15c96dee9f4be0@mail.gmail.com>
References: <201002150155.35786.marek.vasut@gmail.com>
	<f17812d71002150633p1699d012ocf15c96dee9f4be0@mail.gmail.com>
Message-ID: <201002160345.36076.marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dne Po 15. ?nora 2010 15:33:03 Eric Miao napsal(a):
> On Mon, Feb 15, 2010 at 8:55 AM, Marek Vasut <marek.vasut@gmail.com> wrote:
> > This patch adds SMEMC preconfiguration that was proposed in the "[PXA320]
> > How to find  I/O registers, base address of ASIX ethernet chip?" thread.
> >
> > Comments are welcome, as it is it's just a quick thing, but it works.
> > This addition should be harmless.
> >
> > Signed-off-by: Marek Vasut <marek.vasut@gmail.com>
> 
> I'd expect a more intuitive way to configure the static memory controller,
> actually the configuration is so complex that this task is no easy :)
> 
Yeah, I know ... I'd like to get some comments, that's why I started this. 
What's your idea actually ? You'd like to configure both NFC and SMC through 
this (section 2.2 in vol II) ?

Cheers!
