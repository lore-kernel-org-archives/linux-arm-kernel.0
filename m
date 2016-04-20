From: baruch@tkos.co.il (Baruch Siach)
Date: Wed, 20 Apr 2016 23:32:54 +0300
Subject: Looking for information on modern(ish) use of spidev
In-Reply-To: <CAF_dkJDNV5TaX4y+c6s8y5JRH5LtWY5Kaaa=hEMY3aYf_aCdVA@mail.gmail.com>
References: <CAF_dkJDRaidOF5p1B+ssx=SKgUHonMj5TbG2mT3wE5bOdDw69g@mail.gmail.com>
 <20160420202052.GM2476@tarshish>
 <CAF_dkJDNV5TaX4y+c6s8y5JRH5LtWY5Kaaa=hEMY3aYf_aCdVA@mail.gmail.com>
Message-ID: <20160420203254.GN2476@tarshish>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Patrick,

On Wed, Apr 20, 2016 at 04:29:01PM -0400, Patrick Doyle wrote:
> Thank you for your quick reply.  I have added spidev entries to my
> device tree following the models I found in arch/arm/boot/dts, but no
> entries show up in /dev, upon which my devtmpfs is mounted.  Do I need
> to do anything special to make the entries show up, such as running a
> udev or mdev daemon (which I am not currently running)?

devtmpfs should be enough.

Are you sure you enabled CONFIG_SPI_SPIDEV in your kernel? Does your SPI 
master driver probe successfully?

baruch

-- 
     http://baruch.siach.name/blog/                  ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch at tkos.co.il - tel: +972.2.679.5364, http://www.tkos.co.il -
