From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri, 05 Apr 2013 23:13:58 +0200
Subject: [PATCH v2 2/9] arm: mvebu: Align the internal registers virtual
 base to support LPAE
In-Reply-To: <201304052250.28641.arnd@arndb.de>
References: <1365193444-13441-1-git-send-email-gregory.clement@free-electrons.com>
 <1365193444-13441-3-git-send-email-gregory.clement@free-electrons.com>
 <201304052250.28641.arnd@arndb.de>
Message-ID: <515F3E96.4040307@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/05/2013 10:50 PM, Arnd Bergmann wrote:
> On Friday 05 April 2013, Gregory CLEMENT wrote:
>> From: Lior Amsalem <alior@marvell.com>
>>
>> In order to be able to support he LPAE, the internal registers virtual
>> base must be aligned to 2MB.
>>
>> Signed-off-by: Lior Amsalem <alior@marvell.com>
>> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> 
> This is a surprising limitation. Can you extend the above text to go into more
> detail where that alignment requirement comes from?
> 

The explanation I had was that in LPAE section size is 2MB, in earlyprintk we map
the internal registers and it must be section aligned.

> 	Arnd
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 


-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
