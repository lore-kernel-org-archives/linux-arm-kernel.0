From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Fri, 17 Mar 2017 11:43:14 +0000
Subject: [PATCH v3 00/25] arm/arm64: KVM: Rework the hyp-stub API
In-Reply-To: <4bf5788f-7ed8-198e-8089-1c7a8385f96b@arm.com>
References: <20170306142458.8875-1-marc.zyngier@arm.com>
 <20170314160545.GP21222@n2100.armlinux.org.uk>
 <4bf5788f-7ed8-198e-8089-1c7a8385f96b@arm.com>
Message-ID: <20170317114314.GA21222@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 14, 2017 at 04:09:44PM +0000, Marc Zyngier wrote:
> On 14/03/17 16:05, Russell King - ARM Linux wrote:
> > On Mon, Mar 06, 2017 at 02:24:33PM +0000, Marc Zyngier wrote:
> >> As noticed by RMK in this thread[1], the hyp-stub API on 32bit ARM
> >> could do with some TLC (it cannot perform a soft-restart at HYP, and
> >> has holes in the hyp-stub support in a number of places). In general,
> >> it would be desirable for the 32bit behaviour to align on 64bit, if
> >> only to ease maintenance.
> > 
> > What's the merge plan for this?
> 
> If you're happy with it (together with Christoffer, Will and Catalin), I
> plat to take it through the kvmarm tree.

Acked-by: Russell King <rmk+kernel@armlinux.org.uk>

Thanks.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
