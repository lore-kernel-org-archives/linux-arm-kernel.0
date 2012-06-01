From: hpa@zytor.com (H. Peter Anvin)
Date: Fri, 01 Jun 2012 11:46:24 -0700
Subject: [PATCH] lib/decompress_unxz.c: removing all memory helper
 functions
In-Reply-To: <4FC90C01.2060005@hp.com>
References: <1337875436-27640-1-git-send-email-tmac@hp.com>
 <20120528070336.GM3377@game.jcrosoft.org> <4FC82D89.1040108@hp.com>
 <4FC83940.9010708@zytor.com> <4FC90C01.2060005@hp.com>
Message-ID: <4FC90E00.7010100@zytor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/01/2012 11:37 AM, Thavatchai Makphaibulcboke wrote:
> On 05/31/2012 09:38 PM, H. Peter Anvin wrote:
>> We could always make a source code library, like we already in effect
>> have for the compression functions themselves.
>>
>> 	-hpa
>>
> 
> Thanks for the suggestion and comment.  I guess we could add a new
> directory with a new file under arch, such as arch/lib/mem.c and use the
> source include similar to the compression.
> 

Well, the decompression stuff is under lib/ ... maybe lib/boot/ or
something like that...

	-hpa


-- 
H. Peter Anvin, Intel Open Source Technology Center
I work for Intel.  I don't speak on their behalf.
