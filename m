From: geoff@infradead.org (Geoff Levand)
Date: Tue, 15 Jul 2014 10:04:58 -0700
Subject: Kexec on arm64
In-Reply-To: <CAFdej006OSyhgDcJ2iZdbjt+PtysN=i_+9Dr4GTmr=+t5yg4Kw@mail.gmail.com>
References: <CAFdej006OSyhgDcJ2iZdbjt+PtysN=i_+9Dr4GTmr=+t5yg4Kw@mail.gmail.com>
Message-ID: <1405443898.22585.7.camel@smoke>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, 2014-07-15 at 21:35 +0530, Arun Chandran wrote:
> So I am assuming some code at 0x238 is waiting for
> secondary_kernel_start address
> @000000400000fff8
> 
> So I modified my dtb file and made 0x238 as 'cpu-return-addr '
> 
...
> 
> Is this correct?

I doubt it.  I recommend you contact whoever you are contracted to do
this work for and ask them for the value.

As I mentioned in a mail from yesterday, I pushed out a work around for
this.  Did you try it?

For anyone who comes across this thread and wants to follow it back to
find that mail I sent out, good luck...

-Geoff
