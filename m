From: wpdster@gmail.com (Patrick Doyle)
Date: Wed, 20 Apr 2016 16:29:01 -0400
Subject: Looking for information on modern(ish) use of spidev
In-Reply-To: <20160420202052.GM2476@tarshish>
References: <CAF_dkJDRaidOF5p1B+ssx=SKgUHonMj5TbG2mT3wE5bOdDw69g@mail.gmail.com>
 <20160420202052.GM2476@tarshish>
Message-ID: <CAF_dkJDNV5TaX4y+c6s8y5JRH5LtWY5Kaaa=hEMY3aYf_aCdVA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 20, 2016 at 4:20 PM, Baruch Siach <baruch@tkos.co.il> wrote:
> On Wed, Apr 20, 2016 at 03:55:42PM -0400, Patrick Doyle wrote:
>> Can anybody point me at a relatively recent tutorial/explanation of
>> the current usage of spidev?
> For half duplex transfers just read/write the spidev device node. For
> something more complex see the examples under tools/spi/.
>
Hi Baruch,
Thank you for your quick reply.  I have added spidev entries to my
device tree following the models I found in arch/arm/boot/dts, but no
entries show up in /dev, upon which my devtmpfs is mounted.  Do I need
to do anything special to make the entries show up, such as running a
udev or mdev daemon (which I am not currently running)?

--wpd
