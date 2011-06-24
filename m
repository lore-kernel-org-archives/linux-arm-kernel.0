From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 24 Jun 2011 08:42:26 +0100
Subject: [PATCH 23/25] ARM: pm: omap34xx: convert to generic
	suspend/resume support
In-Reply-To: <BANLkTim2ZL8vV9TUofCdq5F=pbFheHQ=Mg@mail.gmail.com>
References: <20110623190900.GH9449@n2100.arm.linux.org.uk>
	<E1QZpOS-0005nt-Fq@rmk-PC.arm.linux.org.uk>
	<BANLkTim2ZL8vV9TUofCdq5F=pbFheHQ=Mg@mail.gmail.com>
Message-ID: <20110624074226.GI9449@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 24, 2011 at 09:37:03AM +0200, Jean Pihet wrote:
> Russell,
> 
> Just a minor remark:
> On Thu, Jun 23, 2011 at 9:16 PM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> > Convert sa11x0 to use the generic CPU suspend/resume support, rather
>                ^^^^^^^ should be 'OMAP3'
> > than implementing its own version. ?Tested on 3430 LDP.
> >
> > Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

Thanks, fixed.
