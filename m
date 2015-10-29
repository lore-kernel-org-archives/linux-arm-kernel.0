From: p.fedin@samsung.com (Pavel Fedin)
Date: Thu, 29 Oct 2015 10:45:16 +0300
Subject: [PATCH v3 1/4] Documentation: dt-bindings: Describe SROMc
 configuration
In-Reply-To: <563183F9.6020806@samsung.com>
References: <cover.1446018918.git.p.fedin@samsung.com>
 <046d990092dc85cf50db9082fc894d93a3ece7c0.1446018918.git.p.fedin@samsung.com>
 <563183F9.6020806@samsung.com>
Message-ID: <008001d1121d$c0fef160$42fcd420$@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

 Hello!

> You missed here a lot of potential Cc. Please use get_maintainer.pl
> script. It *must* be sent to devicetree list.
> 
> Please send it also to DeviceTree maintainers because you are adding
> quite generic names for bindings so they may have interesting thoughts
> on this.
> 
> LKML list is also missing.

 Ok. Next version will go there too.

> Any vendor prefix here? How generic is this?

 I just don't know... Does *everything* really need a vendor prefix? How readable would that be? "compatible" property already says
that it's samsung-exynos-specific. And IMHO it's quite obvious that properties of vendor-specific device are automatically
vendor-specific.
 Ok, i am currently fixing up the rest and will post v4 soon, and will Cc: it to devicetree ML.

 P.S. I intentionally omit the rest of the text in order to avoid overquoting, since we are already focused on some specific things.
If someone wants to get the whole picture, he/she could just browse back to the start of the thread. Or is it considered wrong
approach in this particular ML?

Kind regards,
Pavel Fedin
Expert Engineer
Samsung Electronics Research center Russia
