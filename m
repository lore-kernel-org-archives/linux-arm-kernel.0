From: balbi@ti.com (Felipe Balbi)
Date: Tue, 6 Oct 2015 10:00:29 -0500
Subject: [PATCH v2] arm: omap2: timer: don't disable our timers
In-Reply-To: <20151006080028.GI23801@atomide.com>
References: <1444092332-9011-1-git-send-email-balbi@ti.com>
 <20151006080028.GI23801@atomide.com>
Message-ID: <8737xo3uuq.fsf@saruman.tx.rr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tony Lindgren <tony@atomide.com> writes:

> * Felipe Balbi <balbi@ti.com> [151005 17:49]:
>> We actually want these devices to be created because
>> we will be moving timers to drivers/clocksource and
>> this will prevent them from probing.
>
> Great. Is this safe to appy on it's own? We are not getting
> system timers re-inited to the default values?

not that I could notice. I booted on BBB and AM4. If you give me a few
minutes I can boot again and save console logs for reference.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 818 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151006/41c87994/attachment.sig>
