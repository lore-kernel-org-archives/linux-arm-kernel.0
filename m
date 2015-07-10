From: pebolle@tiscali.nl (Paul Bolle)
Date: Fri, 10 Jul 2015 11:00:13 +0200
Subject: [PATCH v2] coresight: replicator: Use module_platform_driver
In-Reply-To: <CAK-LDb+HSbM2zV8WxipLb8v7g+eL=5vMHcKGttEOdnCjSXSwPA@mail.gmail.com>
References: <20150709195944.GA4470@vaishali-Ideapad-Z570>
 <1436473148.20619.116.camel@tiscali.nl>
 <CAK-LDb+HSbM2zV8WxipLb8v7g+eL=5vMHcKGttEOdnCjSXSwPA@mail.gmail.com>
Message-ID: <1436518813.20619.134.camel@tiscali.nl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On vr, 2015-07-10 at 08:53 +0530, Vaishali Thakkar wrote:
> I thought about this solution before sending this patch. But I was not
> sure about it. Thanks for the explanation. I will send v3 with this
> change.
> 
> Can I add Suggested By: Paul Bolle <pebolle@tiscali.nl>

That should be "Suggested-by:". The net effect would be that, if my
suggestion turns out to be unwise, fan mail will also hit my INBOX,
right? Anyhow, fine with me.

By the way, there's more module specific stuff in
drivers/hwtracing/coresight/. And there's no tristate symbol to be found
in its Kconfig file. So I'd guess there are a few other cleanups
possible too, if someone cared enough to have a closer look at that.


Paul Bolle
