From: richardcochran@gmail.com (Richard Cochran)
Date: Tue, 9 Oct 2012 18:54:05 +0200
Subject: Booting vanilla kernel on the beaglebone
In-Reply-To: <79CD15C6BA57404B839C016229A409A83EB39F42@DBDE01.ent.ti.com>
References: <20120930082802.GA15392@netboy.at.omicron.at>
 <50693ECD.4000000@ti.com>
 <20121008191657.GA3281@netboy.at.omicron.at>
 <79CD15C6BA57404B839C016229A409A83EB39685@DBDE01.ent.ti.com>
 <20121009110049.GB2274@netboy.at.omicron.at>
 <79CD15C6BA57404B839C016229A409A83EB39D66@DBDE01.ent.ti.com>
 <20121009114326.GA4511@netboy.at.omicron.at>
 <79CD15C6BA57404B839C016229A409A83EB39F42@DBDE01.ent.ti.com>
Message-ID: <20121009165405.GB6870@netboy.at.omicron.at>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 09, 2012 at 12:17:45PM +0000, Hiremath, Vaibhav wrote:
> Just with recent u-boot.

So this just doesn't work at all for me. It hangs just after:

   U-Boot# bootm 81000000 - 80000000
   ## Booting kernel from Legacy Image at 81000000 ...
      Image Name:   Linux-3.6.0-next-20121009
      Image Type:   ARM Linux Kernel Image (uncompressed)
      Data Size:    3845136 Bytes = 3.7 MiB
      Load Address: 80008000
      Entry Point:  80008000
      Verifying Checksum ... OK
   ## Flattened Device Tree blob at 80000000
      Booting using the fdt blob at 0x80000000
      Loading Kernel Image ... OK
   OK
      Loading Device Tree to 8fe66000, end 8fe6a433 ... OK
   
   Starting kernel ...

(That was with linux-next-b066f61 from today.)

I do have a Rev A6 board. Could that be an issue?

You said that you are carrying along some patches (like the
defconfig). Are you sure every needed patch is now upstream?

Thanks,
Richard
