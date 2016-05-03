From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 3 May 2016 11:12:59 +0100
Subject: [PATCH 10/12] kexec: arrange for paddr_vmcoreinfo_note() to
 return phys_addr_t
In-Reply-To: <20160503042441.GA2518@x1.redhat.com>
References: <20160428092644.GX19428@n2100.arm.linux.org.uk>
 <E1aviFP-0000je-5t@rmk-PC.arm.linux.org.uk>
 <CAHB_Gur-6oyEheN-Pom7OwivdvrQpCBaXvM1V2H0JPFRCFZthA@mail.gmail.com>
 <20160429151639.GC23726@leverpostej>
 <CAHB_GurwYqPbccLU9UHppLxbBr4Cfs47myKAer-RJicT=T7uBw@mail.gmail.com>
 <20160503042441.GA2518@x1.redhat.com>
Message-ID: <20160503101258.GL19428@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 03, 2016 at 12:24:41PM +0800, Baoquan He wrote:
> Could you please help tell why arm PAE kernel can be put above 4G?
> Since the change is related to common code, I am curious about how
> it's so different with other ARCHs.

This is explained in the covering email to the series.

The explanation given by Pratyush was incomplete.

-- 
RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
