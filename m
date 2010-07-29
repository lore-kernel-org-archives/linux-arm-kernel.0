From: mike@compulab.co.il (Mike Rapoport)
Date: Thu, 29 Jul 2010 19:16:03 +0300
Subject: [PATCH 01/13] [ARM] pxa/palm: Introduce Palm27x
In-Reply-To: <201007291754.02846.marek.vasut@gmail.com>
References: <1280373389-32475-1-git-send-email-marek.vasut@gmail.com>
	<4C515247.4030104@compulab.co.il>
	<201007291754.02846.marek.vasut@gmail.com>
Message-ID: <4C51A943.2010602@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Marek Vasut wrote:
> Dne ?t 29. ?ervence 2010 12:04:55 Mike Rapoport napsal(a):
>> Marek Vasut wrote:
>>> This contains common code for Palm LD, TX, T5, Z72, Treo680, Centro
>>>
>>> Signed-off-by: Marek Vasut <marek.vasut@gmail.com>
>>> ---
>>>

[ snip ]

> Hey Mike,
> 
> I'll push the changes you suggested in a separate patch to avoid breaking the 
> already existing code (I can't currently test this on all affected platforms, 
> but I should be able to do it once I get another palmld). Especially I'll have 
> to analyze the PMIC change.

Using PIO mode on power I2C interface allows communications with PMIC late in 
suspend and early during resume. If it's not required for Palms, just skip the 
comment.

> Thanks for the review !
> Cheers


-- 
Sincerely yours,
Mike.
