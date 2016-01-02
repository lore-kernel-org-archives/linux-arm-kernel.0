From: mike.looijmans@topic.nl (Mike Looijmans)
Date: Sat, 02 Jan 2016 19:35:32 +0100
Subject: [Question about DMA] Consistent memory?
In-Reply-To: <20160102103948.GR8644@n2100.arm.linux.org.uk>
References: <CAK7LNASd1amcHinXzYy=8mtYbnHUY1G_v=fthpachAVSyjqPZA@mail.gmail.com>
 <20160102103948.GR8644@n2100.arm.linux.org.uk>
Message-ID: <56881874.4050907@topic.nl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2-1-2016 11:39, Russell King - ARM Linux wrote:
> On Thu, Dec 31, 2015 at 04:50:54PM +0900, Masahiro Yamada wrote:
>> Hi.
>>
>> I am new to the Linux DMA APIs.
>>
>> First, I started by reading Documentation/DMA-API.txt,
>> but I am confused with the term "consistent memory".
>
> Just read "coherent memory" instead - the documentation confusingly uses
> the two terms to refer to the same thing.  I think there was a patch a
> while back to replace "consistent" with "coherent" in this document,
> though I'm not sure what happened to it.

I wrote that patch. I never got any comments on it, so either I didn't 
post it to the right people, or no one really cares:
http://www.kernelhub.org/?msg=747166&p=2

I still think that if the kernel methods all have "coherent" in their 
name, we should use the word "coherent" in the documentation as well, 
and not confuse people even further. So I'd happily repost that patch.


-- 
Mike Looijmans
