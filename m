From: t-kristo@ti.com (Tero Kristo)
Date: Thu, 10 Oct 2013 10:18:06 +0300
Subject: [PATCHv7 00/36] ARM: OMAP: clock data conversion to DT
In-Reply-To: <alpine.DEB.2.02.1310091858411.30199@utopia.booyaka.com>
References: <1380098922-30340-1-git-send-email-t-kristo@ti.com>
 <524EE00F.7010208@ti.com> <20131007021556.GV8949@atomide.com>
 <52525642.8010307@ti.com> <20131007154103.GW8949@atomide.com>
 <20131007190322.GY8949@atomide.com>
 <alpine.DEB.2.02.1310091551540.30199@utopia.booyaka.com>
 <alpine.DEB.2.02.1310091858411.30199@utopia.booyaka.com>
Message-ID: <525654AE.7060009@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/09/2013 09:59 PM, Paul Walmsley wrote:
> Eh, one correction:
>
> On Wed, 9 Oct 2013, Paul Walmsley wrote:
>
>> We could easily wind up with kernels that won't boot at all when used
>> with newer DT data.
>
> This is a misstatement of the issue: the concern here is that newer
> kernels may not boot at all with older DT data - which could easily be in
> locked areas of the flash or firmware.

I wonder who would be crazy enough to put DT data into a locked area, 
and to what purpose. If you can update the kernel, there is no point 
locking down DT data, this will just cause you unnecessary misery.

-Tero
