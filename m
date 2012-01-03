From: aspotashev@emcraft.com (Alexander Potashev)
Date: Tue, 03 Jan 2012 20:10:59 +0400
Subject: Renaming MACH_TYPE_KINETIS_K60 into MACH_TYPE_KINETIS
In-Reply-To: <20120103153203.GV2914@n2100.arm.linux.org.uk>
References: <1325065882.1584.153.camel@skywanderer.emcraft.com>
 <2101657.NNXDtBpq3c@myhost> <20120103153203.GV2914@n2100.arm.linux.org.uk>
Message-ID: <1874472.4krplCoJty@myhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 3 ?????? 2012 15:32:03 Russell King - ARM Linux wrote:
> There's also the issue whether DT on uclinux makes sense as these
> platforms are normally highly focussed and highly embedded (and it
> really doesn't make that much sense to have a single kernel image
> running on all.)

Right. Our workflow is to have a custom kernel image for every particular 
embedded system and we are happy with it.
