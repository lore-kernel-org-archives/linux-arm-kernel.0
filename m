From: grant.likely@secretlab.ca (Grant Likely)
Date: Thu, 26 May 2011 16:16:10 -0600
Subject: [PATCH] ARM: Xilinx: Adding zynq platform support
In-Reply-To: <BANLkTi=mL=J4UeKgFEa9y3C==8f9eKkboA@mail.gmail.com>
References: <BANLkTiknh4nCviohecbcJEiWnSW-JdMxDw@mail.gmail.com>
	<alpine.LFD.2.00.1105241435550.3207@xanadu.home>
	<BANLkTi=hCpCbNzi1ZiKmGnbhmCG2Ce=EkA@mail.gmail.com>
	<201105261559.41993.arnd@arndb.de>
	<20110526150655.GA26661@ponder.secretlab.ca>
	<20110526220120.GN24876@n2100.arm.linux.org.uk>
	<BANLkTi=mL=J4UeKgFEa9y3C==8f9eKkboA@mail.gmail.com>
Message-ID: <BANLkTin40KK-SahXEP3c1EH1+fWgB54aFw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 26, 2011 at 4:13 PM, Grant Likely <grant.likely@secretlab.ca> wrote:
> On Thu, May 26, 2011 at 4:01 PM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
>> On Thu, May 26, 2011 at 09:06:55AM -0600, Grant Likely wrote:
>>> On Thu, May 26, 2011 at 03:59:41PM +0200, Arnd Bergmann wrote:
>>> > On Wednesday 25 May 2011, Grant Likely wrote:
>>> > >
>>> > > As per discussion attached below. ?Please pull this tree adding device
>>> > > tree support to ARM, plus some other minor device tree changes.
>>> >
>>> > Hi Grant and Linus,
>>> >
>>> > There is also the new Xilinx zynq subarchitecture pending that depends
>>> > on this, see below. Should we also include that right away, in order
>>> > to have an example for other platforms? I think the code is clean
>>> > enough and it would be good to have.
>>> >
>>> > ? ? Arnd
>>>
>>> Yes, this one definitely should (as we discussed in Budapest 2 weeks back).
>>> Its been in linux-next for a while now too.
>>>
>>> I've picked it up into devicetree/arm-next and run through a few build
>>> tests before I push it out and update the pull request.
>>
>> Note that I've pulled the dt stuff into my tree a few days ago already.
>
> Even better. ?Thanks.

Will you pick up the zynq patch also?

g.


-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
