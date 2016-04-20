From: wpdster@gmail.com (Patrick Doyle)
Date: Wed, 20 Apr 2016 16:35:13 -0400
Subject: Looking for information on modern(ish) use of spidev
In-Reply-To: <20160420203254.GN2476@tarshish>
References: <CAF_dkJDRaidOF5p1B+ssx=SKgUHonMj5TbG2mT3wE5bOdDw69g@mail.gmail.com>
 <20160420202052.GM2476@tarshish>
 <CAF_dkJDNV5TaX4y+c6s8y5JRH5LtWY5Kaaa=hEMY3aYf_aCdVA@mail.gmail.com>
 <20160420203254.GN2476@tarshish>
Message-ID: <CAF_dkJDR7UEwf6-Ti6-Ocj-nWrB0_CzH4cJVG_QvOz0MqcXZJA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 20, 2016 at 4:32 PM, Baruch Siach <baruch@tkos.co.il> wrote:
> Hi Patrick,
> Are you sure you enabled CONFIG_SPI_SPIDEV in your kernel? Does your SPI
> master driver probe successfully?
It is configured as a module (and complains wildly when I modprobe it
with entries in my device tree).

The master driver probes and shows in in /sys/class/spi_master.

--wpd
