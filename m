From: manabian@gmail.com (Joachim Eastwood)
Date: Thu, 8 May 2014 11:11:22 +0200
Subject: OMAP baseline test results for v3.15-rc4
In-Reply-To: <alpine.DEB.2.02.1405080417150.23579@utopia.booyaka.com>
References: <alpine.DEB.2.02.1405080417150.23579@utopia.booyaka.com>
Message-ID: <CAGhQ9Vx_dJTn20S1OngAks1KvZkH=MUWEh-4bv5ciM7PhofJ8Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 8 May 2014 06:23, Paul Walmsley <paul@pwsan.com> wrote:
>
> Here are some basic OMAP test results for Linux v3.15-rc4.
> Logs and other details at:
>
>     http://www.pwsan.com/omap/testlogs/test_v3.15-rc4/20140505112251/
>
>
> Test summary
> ------------
<snip>
>
> The eMMC on the 4460 VAR-SOM-OM has failed; I guess it's run out of
> reserve blocks to reallocate.  Now it's time to find yet another way
> to boot it.

I have some patches for u-boot which makes it possible to use the
on-board LAN7500 USB Ethernet controller for tftp.

Since you have a VAR-SOM-OM44 module maybe you could test my dts patches for it?
I will post a new version of the patch set early next week. I can cc you.

Do you have the VAR-DVK-OM44 eval board?

regards
Joachim Eastwood
