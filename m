From: mans@mansr.com (=?iso-8859-1?Q?M=E5ns_Rullg=E5rd?=)
Date: Tue, 24 Sep 2013 13:11:38 +0100
Subject: new binutils needed for arm in 3.12-rc1
In-Reply-To: <1379988800.1974.68@driftwood> (Rob Landley's message of "Mon, 23
 Sep 2013 21:13:20 -0500")
References: <20130923235917.GA30967@amd.pavel.ucw.cz>
 <1379988800.1974.68@driftwood>
Message-ID: <yw1xpprywhad.fsf@unicorn.mansr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Rob Landley <rob@landley.net> writes:

> On 09/23/2013 06:59:17 PM, Pavel Machek wrote:
>> During 3.12-rc, Will Deacon introduced code into arch/arm that
>> requires binutils 2.22.
>
> Um, my toolchain is using the last gplv2 snapshot of binutils out of  
> git, which is just past 2.17 and can build armv7 (but not armv8).
>
> Binutils 2.12->2.22 is quite the jump. (11 years.) I'd except some  
> thought to have gone into that? Possibly a mention of it?

I seriously doubt that 2.12 still works at all (I doubt it can even be
built on a modern system).  In my experience, binutils older than 2.19
or so rarely works properly for ARM.

What value is there in maintaining compatibility with a truly ancient
binutils version anyway?

-- 
M?ns Rullg?rd
mans at mansr.com
