From: jon-hunter@ti.com (Jon Hunter)
Date: Fri, 28 Sep 2012 17:17:03 -0500
Subject: [PATCH V2 0/7] ARM: OMAP2+: Add device-tree support for timers
In-Reply-To: <5065F19E.5020708@ti.com>
References: <1347579091-3794-1-git-send-email-jon-hunter@ti.com>
 <505A7E0B.30709@ti.com> <20120920235309.GO28835@atomide.com>
 <5063330E.3000203@ti.com> <5065F19E.5020708@ti.com>
Message-ID: <506621DF.20508@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 09/28/2012 01:51 PM, Vaibhav Hiremath wrote:

[snip]

> Jon,
> 
> Sorry for delayed response, But I tried using your omap_test application
> to validate this patch series, but it is failing for me.
> 
> How did you test it? Are you running same test application at your end?
> 
> I am debugging this issue, i just thought I should tell you this before
> its too late.

By the way, I have not seen any such issues on OMAP2/3/4 and so this
appears to be specific to AM335x. So I would not be too concerned, we
just need to understand why interrupts on some timers are not working on
the AM335x. Probably a configuration issue some where and that can
always be fixed separately.

Cheers
Jon
