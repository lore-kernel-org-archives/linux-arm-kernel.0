From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Fri, 16 Oct 2009 13:32:20 -0400
Subject: [PATCH 1/2] Update ts72xx to use generic platform nand driver
In-Reply-To: <1255713631.18879.675.camel@macbook.infradead.org>
References: <BD79186B4FD85F4B8E60E381CAEE190901DB7967@mi8nycmail19.Mi8.com>
	<1255260621.16942.38.camel@localhost>
	<BD79186B4FD85F4B8E60E381CAEE190901DB7E59@mi8nycmail19.Mi8.com>
	<1255509739.32489.123.camel@localhost>
	<BD79186B4FD85F4B8E60E381CAEE190901DB8132@mi8nycmail19.Mi8.com>
	<1255675123.32489.310.camel@localhost>
	<BD79186B4FD85F4B8E60E381CAEE190901E244EA@mi8nycmail19.Mi8.com>
	<1255713631.18879.675.camel@macbook.infradead.org>
Message-ID: <BD79186B4FD85F4B8E60E381CAEE190901E244F4@mi8nycmail19.Mi8.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday, October 16, 2009 10:21 AM, David Woodhouse wrote:
> On Fri, 2009-10-16 at 13:09 -0400, H Hartley Sweeten wrote:
>> +               pr_warning("ts72xx: Unknown nand disk size:%lluMB\n", size >> 20);
>
> If it's >>20, then you mean 'MiB' not 'MB'.

Thanks.  I will update the patch.

Stupid question... What does the 'i' stand for?  I see in lib/string_helpers.c that
all the units_10[] values don't have the 'i' and units_2[] do but I would like to
know what it actually means.

Regards,
Hartley
