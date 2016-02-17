From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Wed, 17 Feb 2016 17:03:15 +0100
Subject: [PATCH v4 00/12] Add support for the Armada 3700 SoC an mvebu
 ARM64 based
In-Reply-To: <2699923.cugyhCaCQy@wuerfel> (Arnd Bergmann's message of "Tue, 16
 Feb 2016 22:22:11 +0100")
References: <1455646502-23834-1-git-send-email-gregory.clement@free-electrons.com>
 <2699923.cugyhCaCQy@wuerfel>
Message-ID: <87a8mzs4sc.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,
 
 On mar., f?vr. 16 2016, Arnd Bergmann <arnd@arndb.de> wrote:

> On Tuesday 16 February 2016 19:14:50 Gregory CLEMENT wrote:
>> This series introduce the support of the Armada 3700 family: it is the
>> first ARM64 SoC of the mvebu family submitted to the mainline!
>> 
>> Currently there are two members of the Armada 3700 family, the only
>> difference is the number of core: the Armada 3710 comes with one
>> Cortex-A53 whereas the Armada 3720 comes with 2 Cortex-A53. In this
>> series we enabled only the minimum to boot, pinctrl and clock tree
>> will come soon.
>> 
>
> Whole series
>
> Acked-by: Arnd Bergmann <arnd@arndb.de>

Great!

I am going to do a first pull requests for the mvebu arm64. Let me know
if I do it correctly.

Thanks,

Gregory

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
