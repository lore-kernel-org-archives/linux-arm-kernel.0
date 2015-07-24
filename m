From: sudeep.holla@arm.com (Sudeep Holla)
Date: Fri, 24 Jul 2015 14:00:18 +0100
Subject: inquiries on juno
In-Reply-To: <CAN2waFsDuw4s9AqU=6D5vfgHSK5iDknkxD5UR06yXGe+GGNSrg@mail.gmail.com>
References: <CAN2waFugZ869RZe_3GbW+8qCZQL-h9fRt5g38JJUPkr8f8VR5A@mail.gmail.com>	<55B20037.2090705@arm.com>
 <CAN2waFsDuw4s9AqU=6D5vfgHSK5iDknkxD5UR06yXGe+GGNSrg@mail.gmail.com>
Message-ID: <55B236E2.8050600@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 24/07/15 13:17, Zhaoyang Huang wrote:
> Dear Sudeep,
> Thanks for your quick feedback. I just use the dtb which I compiled by
> the upstreaming source code. So you mean I should use the upstreamed
> binary dtb file instead of the one which I compiled out?
>

No the one you have compiled should work. Try adding "earlycon" to the
command line and see if that works. You might have to apply[1] to get
earlycon working as Juno DTS specifies baud in stdout-path and currently
earlycon parsing has issues which [1] fixes.

Regards,
Sudeep

[1] https://lkml.org/lkml/2015/4/8/604
