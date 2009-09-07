From: jacmet@sunsite.dk (Peter Korsgaard)
Date: Mon, 07 Sep 2009 19:53:11 +0200
Subject: Discussion request for new Samsung SoCs maintaining
In-Reply-To: <9c9fda240909070624q33bda480g17aabcfa452578d0@mail.gmail.com>
	(Kyungmin Park's message of "Mon\, 7 Sep 2009 22\:24\:48 +0900")
References: <24498970.196691251371216483.JavaMail.weblogic@epml12>
	<4A967FB0.8090502@billgatliff.com>
	<20090901133812.GP19719@n2100.arm.linux.org.uk>
	<9c9fda240909070624q33bda480g17aabcfa452578d0@mail.gmail.com>
Message-ID: <87vdju63qw.fsf@macbook.be.48ers.dk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>>>>> "Kyungmin" == Kyungmin Park <kmpark@infradead.org> writes:

Hi,

 Kyungmin> How about to finish the this issues.
 Kyungmin> Even though Ben don't give any opinion, we have to decide how
 Kyungmin> to add next new SoCs and drivers.

 Kyungmin> First, decide the proper platform directory.
 Kyungmin> 1. use the plat-s3c,
 Kyungmin> 2. rename plat-samsung or
 Kyungmin> 3. create new plat-samsung.

Any real reason to not go with 1?

 Kyungmin> Second, who maintains the new SoCs?
 Kyungmin> 1. maintain the all samsung SoCs as before by Ben
 Kyungmin> 2. maintain s3c24xx and s3c64xx by Ben. others (s5pc1xx
 Kyungmin> series) by Samsung.

Unless Ben disagrees, I don't see why we shouldn't go for 1 here as
well?

-- 
Bye, Peter Korsgaard
