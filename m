From: kmpark@infradead.org (Kyungmin Park)
Date: Mon, 7 Sep 2009 22:24:48 +0900
Subject: Discussion request for new Samsung SoCs maintaining
In-Reply-To: <20090901133812.GP19719@n2100.arm.linux.org.uk>
References: <24498970.196691251371216483.JavaMail.weblogic@epml12>
	<4A967FB0.8090502@billgatliff.com>
	<20090901133812.GP19719@n2100.arm.linux.org.uk>
Message-ID: <9c9fda240909070624q33bda480g17aabcfa452578d0@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

hi,

On Tue, Sep 1, 2009 at 10:38 PM, Russell King - ARM
Linux<linux@arm.linux.org.uk> wrote:
> On Thu, Aug 27, 2009 at 07:44:32AM -0500, Bill Gatliff wrote:
>> I'm not sure I have any useful suggestion for this part. ?It would have
>> been nice to have a "mach-a8" and "mach-arm11" for these situations,
>
> A8 and ARM11 are CPU types and we already have a perfectly good
> abstraction for these. ?Should the Realview ARM11 end up in mach-arm11
> and the Realview Cortex A8 end up in mach-a8? ?Clearly, it's just
> wrong.

How about to finish the this issues.
Even though Ben don't give any opinion, we have to decide how to add
next new SoCs and drivers.

First, decide the proper platform directory.
1. use the plat-s3c,
2. rename plat-samsung or
3. create new plat-samsung.

Second, who maintains the new SoCs?
1. maintain the all samsung SoCs as before by Ben
2. maintain s3c24xx and s3c64xx by Ben. others (s5pc1xx series) by Samsung.

Please give your opinions.

Thank you,
Kyungmin Park
