From: tj@kernel.org (Tejun Heo)
Date: Thu, 21 May 2015 18:23:50 -0400
Subject: [PATCH v3 0/5] AHCI and SATA PHY support for Broadcom STB SoCs
In-Reply-To: <20150521221306.GF11598@ld-irv-0074>
References: <1431473303-18873-1-git-send-email-computersforpeace@gmail.com>
 <555DDC2B.1040608@ti.com> <20150521220050.GF4914@htj.duckdns.org>
 <20150521220138.GG4914@htj.duckdns.org>
 <20150521220328.GE11598@ld-irv-0074>
 <20150521220430.GI4914@htj.duckdns.org>
 <20150521221306.GF11598@ld-irv-0074>
Message-ID: <20150521222350.GN4914@htj.duckdns.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Thu, May 21, 2015 at 03:13:06PM -0700, Brian Norris wrote:
> Most subsystems take device tree binding patches for their constituent
> drivers. And I see you've been merging others:
> 
> e35b98849f25 ata: sata_rcar: Add r8a7793 device support
> 8340bfeb03 ahci: st: Update the ahci_st DT documentation
> af64dce4cb3a ahci: st: Provide DT bindings for ST's SATA implementation
> a1a205df6ee2 ahci: add support for Hisilicon sata
> 
> All have your sign-off / commit stamp.

Yeap, I've been routing some of them.

> > Is this
> > an exception?
> 
> Not that I know of. Where would you like it to go instead?

But the rules have never been clear to me.  If the subsystem
maintainer is okay with it, I'm happy to take the patches.  I'm just
kinda curious why this doesn't go through devicetree tree while some
other devicetree patches go through there.  Can somebody explain the
overall policy to me?  I'm not looking for some absolute rules and
exceptions are fine but I do wanna have a general direction.

Thanks.

-- 
tejun
