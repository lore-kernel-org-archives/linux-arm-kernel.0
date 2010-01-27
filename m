From: mcuelenaere@gmail.com (Maurus Cuelenaere)
Date: Wed, 27 Jan 2010 01:32:24 +0100
Subject: [PATCH 2/4] ARM: SAMSUNG: Rename s3c24xx touchscreen interface
	to s3c
In-Reply-To: <4B5F1229.9030304@gmail.com>
References: <b2e8f9f71001221447k897b5cfs213447084543ee55@mail.gmail.com>
	<20100126145558.GE9153@trinity.fluff.org>
	<4B5F1229.9030304@gmail.com>
Message-ID: <4B5F8998.90602@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Op 26-01-10 17:02, Maurus Cuelenaere schreef:
> Op 26-01-10 15:55, Ben Dooks schreef:
>> On Fri, Jan 22, 2010 at 11:47:11PM +0100, Maurus Cuelenaere wrote:
>>> ARM: SAMSUNG: Rename s3c24xx touchscreen interface to s3c
>>>
>>> Signed-off-by: Maurus Cuelenaere<mcuelenaere@gmail.com>
>> Renaming for naming sake is in my view just a waste of diff, unless
>> anyone disagrees here.
>
> Well I don't think it's pointless, having s3c24xx_ts_set_platdata() 
> and s3c2410_ts_mach_info instead of their s3c_ equivalents make it 
> look like the API only handles s3c24xx platforms, which isn't true 
> (anymore).
>
> But I can remove this commit, if you want to.

I have removed this commit and rebased the patches in my tree, will 
repost them when an appropriate solution for the ADC/TS resource sharing 
has been found.

-- 
Maurus Cuelenaere
