From: linux@solonet.org.ua (Denis Kuzmenko)
Date: Thu, 15 Dec 2011 01:30:13 +0200
Subject: [linux-next] make  s5p64x0_defconfig build error
In-Reply-To: <20111214191205.GF14542@n2100.arm.linux.org.uk>
References: <1323838630.18517.1.camel@phoenix>
 <20111214123244.GE7122@mudshark.cambridge.arm.com>
 <20111214191205.GF14542@n2100.arm.linux.org.uk>
Message-ID: <4EE93185.9030502@solonet.org.ua>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/14/2011 09:12 PM, Russell King - ARM Linux wrote:
> On Wed, Dec 14, 2011 at 12:32:44PM +0000, Will Deacon wrote:
>> On Wed, Dec 14, 2011 at 04:57:10AM +0000, Axel Lin wrote:
> So... unless things change, we can expect Gemini, almost all Samsung
> stuff, shmobile, vt8500, and Telechips TCC8k to be at least broken at
> the next merge window.

Mini2440 march (s3c24xx platform) is not broken in v3.2-rc5. Does that
mean that s3c24xx is untouched by this issue or this means that I should
use linux-next?
If this problem is related to s3c24xx I'm ready to do my best for saving
that platform from being removed.

-- 
Best regards, Denis Kuzmenko.
