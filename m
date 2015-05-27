From: christian.perone@gmail.com (Christian S. Perone)
Date: Wed, 27 May 2015 15:51:39 -0300
Subject: Hibernation on ARM64
In-Reply-To: <20150525053346.GB17561@cbz-thinkpad>
References: <CAMxMOAtMw3jnyrvn46m0ZeiwtWjRRZ-i21N5+riwn-3qei+szg@mail.gmail.com>
 <20150522110218.GC5623@red-moon> <20150525053346.GB17561@cbz-thinkpad>
Message-ID: <CAMxMOAuvs_n8g=D2g0aYVUWYnpr0YTkbc6+MHdi+eQEaMqm1uQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thanks for the reply Lorenzo and Chen. I asked because it seems that
someone tried before and failed [1] due to some page faults while
calling copy_page(). I'm also interested in testing the patches.

[1] https://lkml.org/lkml/2015/1/10/120

On Mon, May 25, 2015 at 2:33 AM, Chen Baozi <cbz@baozis.org> wrote:
> Hi Lorenzo,
>
> On Fri, May 22, 2015 at 12:02:18PM +0100, Lorenzo Pieralisi wrote:
>> Hi Christian,
>>
>> On Thu, May 21, 2015 at 07:34:06PM +0100, Christian S. Perone wrote:
>> > Hello, I haven't found any information, road map or something like
>> > that for the hibernation support for ARM64, does anyone knows if there
>> > is something planned to support this in near future ?
>>
>> Adding arch support for hibernation to arm64 should be fairly simple,
>> it is not top priority at the moment simply because there are not
>> compelling use-cases (on the PM side most features revolve around
>> CPUidle and suspend-to-idle and S2R).
>>
>> To answer your question, yes I have planned to support it, I just
>> do not want to add it to the kernel for no particular reason, if there
>> are compelling requirements (I guess you are asking for a specific
>> reason) it can be done fairly quickly.
>>
>
> I am also looking forward the hibernation support on arm64. Thanks for
> the information.
>
> Could you please CCed me the hiberation patches when you send them to
> list. I can help test it. :-)
>
> Cheers,
>
> Baozi.



-- 
Blog | Github | Twitter
"Forgive, O Lord, my little jokes on Thee, and I'll forgive Thy great
big joke on me."
