From: tj@kernel.org (Tejun Heo)
Date: Sun, 19 Jan 2014 14:13:49 -0500
Subject: [RFC v3 04/13] ahci-platform: Undo pdata->resume on resume failure
In-Reply-To: <52DC1C15.1030107@redhat.com>
References: <1390088935-7193-1-git-send-email-hdegoede@redhat.com>
 <1390088935-7193-5-git-send-email-hdegoede@redhat.com>
 <20140119112737.GC11123@htj.dyndns.org>
 <52DC1C15.1030107@redhat.com>
Message-ID: <20140119191349.GA32165@mtj.dyndns.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Sun, Jan 19, 2014 at 07:40:21PM +0100, Hans de Goede wrote:
> That sounds like your advocating for just returning from resume on the
> first error without undoing any of the previous steps, have I gotten that
> right?

Yeah, or just ignore reset failure and proceed.

> That sounds as sensible as any other approach on resume errors
> (there are IMHO no good answers), if that is what you mean, shall I do a

Suspending back is the wrong answer tho.

> patch in the next versions of my patch-set doing that ?

Isn't just dropping this patch enough tho?

Thanks.

-- 
tejun
