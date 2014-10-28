From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Tue, 28 Oct 2014 22:11:09 +0100
Subject: [PATCH] fixup! net: pxa168_eth: Provide phy_interface mode on
 platform_data
In-Reply-To: <20141028.164939.509353257563688482.davem@davemloft.net>
References: <1414002412-13615-3-git-send-email-sebastian.hesselbarth@gmail.com>
 <1414231739-7447-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <20141028.164939.509353257563688482.davem@davemloft.net>
Message-ID: <5450066D.2010600@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 28.10.2014 21:49, David Miller wrote:
> From: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> Date: Sat, 25 Oct 2014 12:08:59 +0200
>
>> Do not add phy include to the board file but platform_data include
>> instead.
>>
>> Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
>> ---
>> David,
>>
>> I should have compile tested this patch earlier. I did now on
>> pxa168_defconfig right after I received an 0-day kbuild error
>> on this patch.
>>
>> This is the corresponding fix, can you please squash it in?
>>
>> Thanks and sorry for the noise,
>
> Patch applied to net-next, but:
>
> 1) There is never any way for me to "squash" a patch into an old
>     one.  Once I apply a patch it is a permanent commit in my tree
>     and cannot be undone and/or modified.
>
>     Therefore the only thing you can do is send me a relative fix
>     and that's what shows up in my tree as yet another later commit.

Ok, good to know and sorry for the crippled fixup patch. I was assuming
that net-next is also rebased until pulled/moved to some stable state.

> 2) Always be specific about the target tree in you subject,
>     line.  Never assume I can figure it out by context.

Also, sorry for the little information given.

Thanks,

Sebastian
