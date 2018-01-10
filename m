From: j-keerthy@ti.com (Keerthy)
Date: Wed, 10 Jan 2018 16:29:22 +0530
Subject: NFSroot regression in next with handle inode->i_version
In-Reply-To: <20180109212147.GY3875@atomide.com>
References: <20180109210121.GX3875@atomide.com>
 <1515532316.3571.20.camel@redhat.com> <20180109212147.GY3875@atomide.com>
Message-ID: <b58b7309-a897-dd4a-d992-f77b1341298e@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Wednesday 10 January 2018 02:51 AM, Tony Lindgren wrote:
> * Jeff Layton <jlayton@redhat.com> [180109 21:14]:
>> On Tue, 2018-01-09 at 13:01 -0800, Tony Lindgren wrote:
>>> Commit 4b5bd6a8e7cf ("fs: handle inode->i_version more efficiently")
>>> causes NFSroot to not boot to login in Linux next on my ARM boxes.
> 
>> Krzysztof Kozlowski reported this late last week, and I just pushed an
>> updated branch earlier this morning that should fix this. It looks like
>> the current linux-next HEAD has the fixed patchset now too. Let me know
>> if that doesn't help you.
> 
> OK great, thanks for the update. I'll test again tomorrow and will
> whine again if I'm seeing issues :)

This fixes nfs boot for me on dra7-evm.

Regards,
Keerthy

> 
> Regards,
> 
> Tony
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
