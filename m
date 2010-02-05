From: sameo@linux.intel.com (Samuel Ortiz)
Date: Fri, 5 Feb 2010 10:06:20 +0100
Subject: [PATCH 1/4] mfd: update i2c driver for max8925
In-Reply-To: <771cded01002020622v7fa47689je2a5b1c11e2bb0c7@mail.gmail.com>
References: <771cded01001250307o7e340a0dsf7e02762dad8c953@mail.gmail.com>
	<20100129195405.GB23130@sortiz.org>
	<771cded01002020622v7fa47689je2a5b1c11e2bb0c7@mail.gmail.com>
Message-ID: <20100205090619.GC4715@sortiz.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Haojian

On Tue, Feb 02, 2010 at 09:22:58AM -0500, Haojian Zhuang wrote:
> Yes, the code is not very clear. Now I use i2c_new_dummy() now. Now I
> attache new patches now.
> 
> Updates are in below.
> 1. use i2c_new_dummy() to replace i2c_new_probed_device().
> 2. add onkey driver
> 3. remove unused i2c pointer in rtc driver
> 
> Thanks
> Haojian
All 4 patches applied, many thanks.

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
