From: bhe@redhat.com (Baoquan He)
Date: Tue, 3 May 2016 20:56:49 +0800
Subject: [PATCH 10/12] kexec: arrange for paddr_vmcoreinfo_note() to
 return phys_addr_t
In-Reply-To: <20160503101258.GL19428@n2100.arm.linux.org.uk>
References: <20160428092644.GX19428@n2100.arm.linux.org.uk>
 <E1aviFP-0000je-5t@rmk-PC.arm.linux.org.uk>
 <CAHB_Gur-6oyEheN-Pom7OwivdvrQpCBaXvM1V2H0JPFRCFZthA@mail.gmail.com>
 <20160429151639.GC23726@leverpostej>
 <CAHB_GurwYqPbccLU9UHppLxbBr4Cfs47myKAer-RJicT=T7uBw@mail.gmail.com>
 <20160503042441.GA2518@x1.redhat.com>
 <20160503101258.GL19428@n2100.arm.linux.org.uk>
Message-ID: <20160503125649.GA2656@x1.redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/03/16 at 11:12am, Russell King - ARM Linux wrote:
> On Tue, May 03, 2016 at 12:24:41PM +0800, Baoquan He wrote:
> > Could you please help tell why arm PAE kernel can be put above 4G?
> > Since the change is related to common code, I am curious about how
> > it's so different with other ARCHs.
> 
> This is explained in the covering email to the series.
> 
> The explanation given by Pratyush was incomplete.

Yeah, he said non LPAE also has PHYS_OFFSET later to me. In fact this
patch is totally unharmful to other ARCHes, I just can't stand the
curiosity. Sorry about this.

> 
> -- 
> RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
> FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
> according to speedtest.net.
