From: stigge@antcom.de (Roland Stigge)
Date: Wed, 11 Apr 2012 09:49:28 +0200
Subject: [PATCH v4 04/12] ARM: OMAP1: OHCI: use platform_data fn ptr to
 enable OCPI bus
In-Reply-To: <20120411003528.27059.8836.stgit@dusk>
References: <20120411003454.27059.37500.stgit@dusk>
 <20120411003528.27059.8836.stgit@dusk>
Message-ID: <4F853788.2030007@antcom.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/11/2012 02:35 AM, Paul Walmsley wrote:
> Also interesting is that drivers/usb/host/ohci-nxp.c contains a stub
> for ocpi_enable() - perhaps the NXP chips use a similar OCPI IP block?

I'd rather suspect a copy-paste error here since ocpi_enable() is unused
in ohci-nxp.c and the extern declaration looks like an incomplete but
intended removal.

Will probably just remove this reference in my DT patchset.

Roland
