From: moritz.fischer.private@gmail.com (Moritz Fischer)
Date: Thu, 22 Dec 2016 08:26:04 -0800
Subject: [PATCH] ARM64: zynqmp: Fix i2c node's compatible string
In-Reply-To: <d1e69302-8367-7c57-ecd7-f72861c3a49e@xilinx.com>
References: <1482385788-7187-1-git-send-email-moritz.fischer@ettus.com>
 <d1e69302-8367-7c57-ecd7-f72861c3a49e@xilinx.com>
Message-ID: <CAJYdmeMA74LjDLe=E9KkBWZK+-bxjhLQ4JWk7r8Atwmytx3T5g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Michal,

On Wed, Dec 21, 2016 at 11:35 PM, Michal Simek <michal.simek@xilinx.com> wrote:

> compatible = "cdns,i2c-r1p14", "cdns,i2c-r1p10";

I keep getting that wrong .. .damn ... :) Will resubmit.

> The same of course for u-boot where also p14 should be added to the driver.

Yeah, I realized that part after submitting...

Thanks
