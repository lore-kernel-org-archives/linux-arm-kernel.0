From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Fri, 14 Jan 2011 19:14:16 +0100
Subject: [GIT PULL] AT91: patches for v2.6.38-rc1
In-Reply-To: <20110114180455.GL15996@n2100.arm.linux.org.uk>
References: <4D308F30.6070503@atmel.com>
	<20110114180455.GL15996@n2100.arm.linux.org.uk>
Message-ID: <4D309278.5010603@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 14/01/2011 19:04, Russell King - ARM Linux :
> On Fri, Jan 14, 2011 at 07:00:16PM +0100, Nicolas Ferre wrote:
>> Hi Russell,
>>
>> Can you please pull those little changes for AT91? They add two 
>> new boards already discussed on the mailing list and a little 
>> cleanup patch:
> 
> Has this already been in linux-next?

I must admit that... no.

> We should only be merging new code during a merge window which has
> already had visibility in linux-next, with the exception of bug fixes
> and regression fixes.

I understand your point but those are only *board* files that are lying
around for one or two months.
I was really wishing to see them included in mainline during merge
window as they are not core ARM nor AT91 files...

BTW the git tree is based on the tree you specify to Eric: "9e9bc973".

> Regression fixes can be merged at any time provided they're obvious.
> Any regression fix should be acceptable during the merge window.
> 
> Bug fixes any time up until (I'd say) the last week of the -rc series.

Best regards,
-- 
Nicolas Ferre
