From: eric.engestrom@imgtec.com (Eric Engestrom)
Date: Mon, 25 Apr 2016 11:39:11 +0100
Subject: [PATCH 4/4] ARM: remove duplicate const qualifier
In-Reply-To: <20160425095715.GA2366@piout.net>
References: <1461577678-29517-1-git-send-email-eric.engestrom@imgtec.com>
 <1461577678-29517-4-git-send-email-eric.engestrom@imgtec.com>
 <20160425095715.GA2366@piout.net>
Message-ID: <20160425103911.GO32731@imgtec.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 25, 2016 at 11:57:15AM +0200, Alexandre Belloni wrote:
> Hi,
> 
> this requires a commit message.

OK? This seems rather pointless in this case (and even more so for the
typo fix I sent yesterday), but I guess you have some general rule to
enforce. Would this do then?
"The second `const` is unnecessary, and is simply ignored by most compilers."

> Also, you should think about separating those changes in multiple patches
> to ease inclusion in the kernel.

I'll resend patch #4 as multiple patches. What the way proper to convey
that *multiple* new patches replace *one* old one? Is it enough to just
send those as a reply to this one?

Cheers
