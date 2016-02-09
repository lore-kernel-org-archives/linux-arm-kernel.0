From: edubezval@gmail.com (Eduardo Valentin)
Date: Tue, 9 Feb 2016 13:53:27 -0800
Subject: [PATCH 0/3] arm: dts: DRA7: Add IVA and DSPEVE thermal domain data
In-Reply-To: <56B95EF7.9080107@ti.com>
References: <1454922990-7501-1-git-send-email-j-keerthy@ti.com>
 <20160208195704.GW19432@atomide.com> <56B95EF7.9080107@ti.com>
Message-ID: <20160209215326.GC27284@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 09, 2016 at 09:07:27AM +0530, Keerthy wrote:
> 
> 
> On Tuesday 09 February 2016 01:27 AM, Tony Lindgren wrote:
> >* Keerthy <j-keerthy@ti.com> [160208 01:19]:
> >>OMAP5 has 3 thermal zones cpu, core and multimedia.
> >>On the other hand DRA7 has 5 thermal zones cpu, gpu, core, dspeve
> >>and iva. Currently cpu, core and multimedia are being added via dt
> >>and the other 2 are getting added via kernel. Add the missing thermal
> >>domains in dt so as give the correct trip numbers, type and temperatures.

But the driver would add these default domains only if booted /loaded with
missing DT device entry, right?

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160209/6e42b80d/attachment.sig>
