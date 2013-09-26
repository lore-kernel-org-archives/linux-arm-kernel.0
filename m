From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Thu, 26 Sep 2013 18:00:49 +0100
Subject: new binutils needed for arm in 3.12-rc1
In-Reply-To: <1379988800.1974.68@driftwood>
References: <1379988800.1974.68@driftwood>
Message-ID: <52446841.2030301@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 24/09/13 03:13, Rob Landley wrote:
> On 09/23/2013 06:59:17 PM, Pavel Machek wrote:
>> During 3.12-rc, Will Deacon introduced code into arch/arm that
>> requires binutils 2.22.
>
> Um, my toolchain is using the last gplv2 snapshot of binutils out of
> git, which is just past 2.17 and can build armv7 (but not armv8).
>
> Binutils 2.12->2.22 is quite the jump. (11 years.) I'd except some
> thought to have gone into that? Possibly a mention of it?
>
>> diff --git a/Documentation/Changes b/Documentation/Changes
>> index b175808..0f8deaf 100644
>> --- a/Documentation/Changes
>> +++ b/Documentation/Changes
>> @@ -23,7 +23,7 @@ you probably needn't concern yourself with
>> isdn4k-utils.
>>
>> o Gnu C 3.2 # gcc --version
>> o Gnu make 3.80 # make --version
>> -o binutils 2.12 # ld -v
>> +o binutils 2.22 # ld -v

Out of interest, can I now change my fixes for v3.12 big-endian
series to use .instr instead of .word?

-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius
