From: fweimer@redhat.com (Florian Weimer)
Date: Sun, 5 Aug 2018 20:33:06 +0200
Subject: framebuffer corruption due to overlapping stp instructions on
 arm64
In-Reply-To: <alpine.LRH.2.02.1808040611070.23762@file01.intranet.prod.int.rdu2.redhat.com>
References: <alpine.LRH.2.02.1808021242320.31834@file01.intranet.prod.int.rdu2.redhat.com>
 <CA+=Sn1mWkjuwVnjw6OWWUM=UcP76bdFa680FebCseewHfx3NpA@mail.gmail.com>
 <9acdacdb-3bd5-b71a-3003-e48132ee1371@redhat.com>
 <CAJA7tRZbmnZq7RfvQeYEy_a1ZObWqpFpVdvgsXgsioQ3RyPMuA@mail.gmail.com>
 <CAKv+Gu97QvwoLLK_zueiA_gjg_4Q5cqU4YVUyHUVFFfffdyJaw@mail.gmail.com>
 <11f9185a-7f71-83df-3a57-0a0ae9c1f934@arm.com>
 <alpine.LRH.2.02.1808032046540.24748@file01.intranet.prod.int.rdu2.redhat.com>
 <CA+=Sn1=6F-fGLmXE0VqQHTqTCUKUT=Fz29mMT7349SPFisbZ9A@mail.gmail.com>
 <alpine.LRH.2.02.1808040611070.23762@file01.intranet.prod.int.rdu2.redhat.com>
Message-ID: <fd2cae87-b2df-d8ef-8836-e6cbf8c5f851@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/04/2018 01:04 PM, Mikulas Patocka wrote:
> There's plenty of memcpy's in the graphics stack. No one will be rewriting
> all the graphics drivers because of tiny market share that ARM has in
> desktop computers. So if you refuse to fix things and blame everyone else,
> you can as well announce that you don't want to have PCIe graphics on ARM
> at all.

The POWER toolchain maintainers said pretty much the same thing not too 
long ago.  I wonder how many architectures need to fail until the 
graphics stack is finally fixed.

Thanks,
Florian
