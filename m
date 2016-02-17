From: horms@verge.net.au (Simon Horman)
Date: Wed, 17 Feb 2016 14:54:31 +0900
Subject: [PATCH] ARM: dts: r8a7794: replace gpio-key,wakeup with
 wakeup-source property
In-Reply-To: <56C2F266.5030709@arm.com>
References: <1455572925-27697-1-git-send-email-horms+renesas@verge.net.au>
 <56C2F266.5030709@arm.com>
Message-ID: <20160217055431.GE11534@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 16, 2016 at 09:56:54AM +0000, Sudeep Holla wrote:
> 
> 
> On 15/02/16 21:48, Simon Horman wrote:
> >Though the keyboard driver for GPIO buttons(gpio-keys) will continue to
> >check for/support the legacy "gpio-key,wakeup" boolean property to
> >enable gpio buttons as wakeup source, "wakeup-source" is the new
> >standard binding.
> >
> >This patch replaces the legacy "gpio-key,wakeup" with the unified
> >"wakeup-source" property in order to avoid any futher copy-paste
> >duplication.
> >
> >Changelog text from a similar patch by Sudeep Holla.
> >
> >Cc: Sudeep Holla <sudeep.holla@arm.com>
> 
> Thanks for doing this, not sure how I missed it, was this merged in v4.5?

I believe it came later and it was my error not to include this in the
change that added the nodes in question.
