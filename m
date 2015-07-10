From: vthakkar1994@gmail.com (Vaishali Thakkar)
Date: Fri, 10 Jul 2015 17:17:20 +0530
Subject: [PATCH v2] coresight: replicator: Use module_platform_driver
In-Reply-To: <1436518813.20619.134.camel@tiscali.nl>
References: <20150709195944.GA4470@vaishali-Ideapad-Z570>
 <1436473148.20619.116.camel@tiscali.nl>
 <CAK-LDb+HSbM2zV8WxipLb8v7g+eL=5vMHcKGttEOdnCjSXSwPA@mail.gmail.com>
 <1436518813.20619.134.camel@tiscali.nl>
Message-ID: <CAK-LDb+Yg+wQJ_bM3Usc=hoK-jDOxHy5AsUOAbmg+-dVnOM4KA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 10, 2015 at 2:30 PM, Paul Bolle <pebolle@tiscali.nl> wrote:
> On vr, 2015-07-10 at 08:53 +0530, Vaishali Thakkar wrote:
>> I thought about this solution before sending this patch. But I was not
>> sure about it. Thanks for the explanation. I will send v3 with this
>> change.
>>
>> Can I add Suggested By: Paul Bolle <pebolle@tiscali.nl>
>
> That should be "Suggested-by:". The net effect would be that, if my
> suggestion turns out to be unwise, fan mail will also hit my INBOX,
> right? Anyhow, fine with me.

Ok. Thanks.

> By the way, there's more module specific stuff in
> drivers/hwtracing/coresight/. And there's no tristate symbol to be found
> in its Kconfig file. So I'd guess there are a few other cleanups
> possible too, if someone cared enough to have a closer look at that.
>

Yes. It seems that introducing something like builtin_amba_driver()
can be useful for files which are using module_amba_driver now . But I'm
not sure if Mathieu is ok with it or not? If it seems useful to him, then I
can go for it.

>
> Paul Bolle



-- 
Vaishali
