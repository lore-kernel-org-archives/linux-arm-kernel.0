From: akpm@linux-foundation.org (Andrew Morton)
Date: Wed, 25 Jun 2014 13:04:25 -0700
Subject: [PATCH v3 -next 0/9] CMA: generalize CMA reserved area
 management code
In-Reply-To: <53AAC1B4.5000204@samsung.com>
References: <1402897251-23639-1-git-send-email-iamjoonsoo.kim@lge.com>
 <539EB4C7.3080106@samsung.com>
 <20140617012507.GA6825@js1304-P5Q-DELUXE>
 <20140618135144.297c785260f9e2aebead867c@linux-foundation.org>
 <53AAC1B4.5000204@samsung.com>
Message-ID: <20140625130425.609ad4293781f5ac81772bf9@linux-foundation.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 25 Jun 2014 14:33:56 +0200 Marek Szyprowski <m.szyprowski@samsung.com> wrote:

> > That's probably easier.  Marek, I'll merge these into -mm (and hence
> > -next and git://git.kernel.org/pub/scm/linux/kernel/git/mhocko/mm.git)
> > and shall hold them pending you review/ack/test/etc, OK?
> 
> Ok. I've tested them and they work fine. I'm sorry that you had to wait for
> me for a few days. You can now add:
> 
> Acked-and-tested-by: Marek Szyprowski <m.szyprowski@samsung.com>

Thanks.

> I've also rebased my pending patches onto this set (I will send them soon).
> 
> The question is now if you want to keep the discussed patches in your 
> -mm tree,
> or should I take them to my -next branch. If you like to keep them, I assume
> you will also take the patches which depends on the discussed changes.

Yup, that works.
