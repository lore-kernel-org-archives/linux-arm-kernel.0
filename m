From: will.deacon@arm.com (Will Deacon)
Date: Mon, 25 Mar 2013 10:49:11 +0000
Subject: [PATCH] ARM: hw_breakpoint: Enable debug powerdown only if
 system supports 'has_ossr'
In-Reply-To: <515014A4.5020504@ti.com>
References: <51407120.7030709@ti.com> <51417E58.5050501@ti.com>
 <20130315050014.GA15706@tiny-lites> <5146B972.1010002@ti.com>
 <20130318150724.GC28585@mudshark.cambridge.arm.com>
 <514736D4.4070906@ti.com>
 <20130318170649.GA29585@mudshark.cambridge.arm.com>
 <5148082A.3060503@ti.com>
 <20130319102803.GB22452@mudshark.cambridge.arm.com>
 <515014A4.5020504@ti.com>
Message-ID: <20130325104910.GE12110@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 25, 2013 at 09:11:00AM +0000, Santosh Shilimkar wrote:
> Will,

Hi Santosh,

> Are you going to send the patch for 3.9-rcx ? As I said before without the
> patch OMAP4 CPUILDE is unusable because of that debug noise and hence it
> will be good to get that patch in

It's in Russell's tree, so should be queued for mainline fairly soon.

Will
