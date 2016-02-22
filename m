From: brian.starkey@arm.com (Brian Starkey)
Date: Mon, 22 Feb 2016 12:07:31 +0000
Subject: next-20160222 build: 5 failures 9 warnings (next-20160222)
In-Reply-To: <56CAF868.5020406@arm.com>
References: <E1aXlz4-000486-Pb@optimist> <20160222100832.GX18327@sirena.org.uk>
 <56CAE5E6.7030707@arm.com>
 <20160222115243.GA5779@e106950-lin.cambridge.arm.com>
 <56CAF868.5020406@arm.com>
Message-ID: <20160222120730.GB5779@e106950-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 22, 2016 at 12:00:40PM +0000, Marc Zyngier wrote:
>On 22/02/16 11:52, Brian Starkey wrote:
>>> This will create a new conflict, but will make the resolution 100% 
>>> clear.
>>
>> I applied this, but arm64 defconfig wouldn't build until I uncommented
>> the '#define kvm_call_hyp(...' line.
>>
>> Is that right?
>
>This patch is intended as a merge indication so that when you do the
>merge with the arm64 tree, it conflicts and you can resolve it by going
>the right thing (merging the non-comment version of this line).

Right, now I understand "make the resolution 100% clear" - I guess 100%
clear isn't clear enough for me :-(

I've not seen that used as notation before, thanks for explaining.

-Brian

>
>So yes, uncommenting it is the right thing to do.
>
>Thanks,
>
>	M.
>-- 
>Jazz is not dead. It just smells funny...
>
