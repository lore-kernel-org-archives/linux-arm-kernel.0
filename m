From: moritz.fischer@ettus.com (Moritz Fischer)
Date: Mon, 21 Sep 2015 10:17:23 -0700
Subject: [PATCH v9] dmaengine: Add Xilinx AXI Direct Memory Access Engine
 driver support
In-Reply-To: <55E00050.2020709@xilinx.com>
References: <1440432666-10310-1-git-send-email-appanad@xilinx.com>
 <CAAtXAHccn5UjCg9Qr1Li1c9LfsBXrgF=gpMqJ6stGOaWL0u_-g@mail.gmail.com>
 <55E00050.2020709@xilinx.com>
Message-ID: <CAAtXAHc_wfuzW=ERRqvjcd_Ow5e2RrEcDkiYRuotzCRhq+oUYQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kedar,

I finally got around to test your stuff on hardware. Sorry it took me so long.

[    5.486709] dma1chan0-dma1c: terminating after 5 tests, 0 failures (status 0)

So it looks like it's working. You can already add a

Tested-by: Moritz Fischer <moritz.fischer@ettus.com>

for the driver.

I'll take a closer look at the code this week now that I have a known
good bit file.

Thanks,

Moritz
