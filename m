From: iamjoonsoo.kim@lge.com (Joonsoo Kim)
Date: Fri, 10 Nov 2017 15:46:23 +0900
Subject: n900 in next-20170901
In-Reply-To: <20171110062340.GL28152@atomide.com>
References: <20171108163413.GU28152@atomide.com>
 <20171109000801.GA23982@js1304-P5Q-DELUXE>
 <20171109001113.GZ28152@atomide.com>
 <20171109003639.GB23982@js1304-P5Q-DELUXE>
 <20171109035031.GA24383@js1304-P5Q-DELUXE>
 <20171109150854.GC28152@atomide.com>
 <20171110001315.GA29669@js1304-P5Q-DELUXE>
 <20171110032610.GJ28152@atomide.com>
 <20171110061917.GK28152@atomide.com>
 <20171110062340.GL28152@atomide.com>
Message-ID: <20171110064623.GA32442@js1304-P5Q-DELUXE>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 09, 2017 at 10:23:40PM -0800, Tony Lindgren wrote:
> * Tony Lindgren <tony@atomide.com> [171109 22:19]:
> > * Tony Lindgren <tony@atomide.com> [171110 03:28]:
> > > Then I'll follow up on cleaning up save_secure_ram_context later.
> > 
> > Here's a better version, the static mapping did not get used.. It
> > just moved the area so it happened to work. It needs to be set
> > up as MT_MEMORY_RWX_NONCACHED instead.
> 

I see a better version now. Hmm... I guess that it also has the
problem that I mentioned on first version.

> And FYI, here's what I currently have for the follow-up patch,
> but that can wait a bit.

Okay. So, this patch should be applied on the top of above better version?

Thanks.
