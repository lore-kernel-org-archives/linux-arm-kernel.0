From: yanpai.chen@gmail.com (Andrew Yan-Pai Chen)
Date: Fri, 24 Sep 2010 13:17:41 +0800
Subject: Could it be a case of deadlock on SMP?
In-Reply-To: <20100920185927.GC5177@n2100.arm.linux.org.uk>
References: <AANLkTinNq6WVNT543QcG+1eVB9te1mmypD4pEvpFhqoJ@mail.gmail.com>
	<20100920185927.GC5177@n2100.arm.linux.org.uk>
Message-ID: <AANLkTi=j5A1=VvE9nz5yGEuOt45-ie98S_SwuD9zXSuk@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 21, 2010 at 2:59 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Tue, Sep 21, 2010 at 02:46:57AM +0800, Andrew Yan-Pai Chen wrote:
>> We try to verify our dual-core processor (non v7) by LTP tests.
>
> Is this a non-ARM SMP implementation then?
>
> If this is an ARM SMP implementation, then please provide the
> CPU model, revision and variant information.
>
The CPU we use is still under developing.
It is a ARM SMP implementation which uses v5te ISA by Faraday Tech.


BR,
Andrew
