From: mzoran@crowfest.net (Michael Zoran)
Date: Sun, 22 Jan 2017 01:56:33 -0800
Subject: ARM64: Disabling warnings about deprecated armv8 instructions
In-Reply-To: <1485078760.1308.6.camel@crowfest.net>
References: <1485072424.14066.2.camel@crowfest.net>
 <9647813.NZ2c5cYUSH@localhost> <1485075528.14345.1.camel@crowfest.net>
 <20170122170523.3b4b1235@xhacker> <1485077887.1308.2.camel@crowfest.net>
 <CAKv+Gu9gBPenhOBj9G7rrqi3h_oMi3X7qpmsK+SB1dgBtzfKTg@mail.gmail.com>
 <1485078760.1308.6.camel@crowfest.net>
Message-ID: <1485078993.1308.7.camel@crowfest.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 2017-01-22 at 01:52 -0800, Michael Zoran wrote:
> I'm saying that when running a ELF32 executable, the system needs to
> fake the CPU architecture according to the uname system API and
> /proc/cpuinfo.
> 
> Today, I run uname -a in Raspbian and I get aarch64.? I want it to
> display arm6l or whatever to get Mathematica to load.
> 
> I see some code to make this work on other architectures such as X86,
> but most of this appears to be unimplemented on arm64.

Ideally, the system should detect the specific application and fake the
architecture according to the specific needs of that application.  But 
that sounds like I would be asking for alot there.
