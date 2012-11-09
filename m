From: cavokz@gmail.com (Domenico Andreoli)
Date: Fri, 9 Nov 2012 08:49:14 +0100
Subject: [PATCH] Add support for generic BCM SoC chipsets
In-Reply-To: <509C7771.9020400@wwwdotorg.org>
References: <1352391196-9984-1-git-send-email-csd@broadcom.com>
 <509C7771.9020400@wwwdotorg.org>
Message-ID: <20121109074913.GA25257@glitch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Christian,

On Thu, Nov 08, 2012 at 08:24:33PM -0700, Stephen Warren wrote:
> On 11/08/2012 09:13 AM, Christian Daudt wrote:
> > In order to start upstreaming Broadcom SoC support, create
> > a starting hierarchy, arch and dts files.
> >

Glad to know that Broadcom is interested in mainline :)

> > The first support SoC family that is planned is the
> >  BCM281XX (BCM28145/28150/28155) family of dual A9 mobile SoC cores
> > This code is just the skeleton code for get the machine upstreamed. It
> > has been made MULTIPLATFORM compatible.
> 
> Is the intent for this to support other BCM SoCs in the future, such as
> the bcm2835 in the Raspberry Pi, and the mach-bcm476x which Domenico
> Andreoli recently sent patches for? It'd be awesome if Broadcom could
> provide MMC and USB drivers for the bcm2835 for example.

I'd love to see published some more documentation as well.

Regards,
Domenico
