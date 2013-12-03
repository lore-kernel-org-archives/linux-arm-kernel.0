From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Mon, 2 Dec 2013 19:40:12 -0500
Subject: [PATCH 00/24] mm: Use memblock interface instead of bootmem
In-Reply-To: <20131202163234.3edcb8e77834322314c435ea@linux-foundation.org>
References: <1383954120-24368-1-git-send-email-santosh.shilimkar@ti.com>
 <5298C5C2.60008@ti.com>
 <20131202163234.3edcb8e77834322314c435ea@linux-foundation.org>
Message-ID: <529D286C.30908@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 02 December 2013 07:32 PM, Andrew Morton wrote:
> On Fri, 29 Nov 2013 11:50:10 -0500 Santosh Shilimkar <santosh.shilimkar@ti.com> wrote:
> 
>> Tejun, Andrew,
>>
>> On Friday 08 November 2013 06:41 PM, Santosh Shilimkar wrote:
>>> Tejun and others,
>>>
>>> Following up with the earlier RFC [1] comments, here is the updated
>>> patch series based on the discussion. This series is the last bottleneck
>>> now for me to enable the coherency on keystone ARM LPAE architecture on which
>>> the physical memory starts after 4BG. I would like to get these patches
>>> in next merge window(3.14), so any help in terms of testing/comments is
>>> appreciated.
>>>
>> Now since the 3.13-rc1 is out, it will be best to apply these patches 
>> on memblock tree so that they start appearing in next to catch any
>> regressions, issues etc. It will give us some time to fix any issues
>> arises from next.
>>
>> For convenience, I have re-based the series on top of 3.13-rc1 and
>> pushed it on below tree.
>>
>> git://git.kernel.org/pub/scm/linux/kernel/git/ssantosh/linux-keystone.git
>> for_3.14/memblock
>>
>> web-url:
>> https://git.kernel.org/cgit/linux/kernel/git/ssantosh/linux-keystone.git/log/?h=for_3.14/memblock
>>
>> Can you please pull these in you tree and apply against your
>> next branch ?
> 
> It would cause me much joy if yinghai were able to find time to review
> all this.  The patches are a bit old now, so perhaps a resend will help.
> 
OK. I will re-send the patchset.

Regards,
Santosh
