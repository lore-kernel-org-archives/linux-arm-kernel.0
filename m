From: b.brezillon@overkiz.com (boris brezillon)
Date: Thu, 18 Jul 2013 13:33:49 +0200
Subject: [PATCH v4 5/5] ASoC: atmel-ssc: remove clk_disable_unprepare
 call from critical section
In-Reply-To: <20130718105846.GJ22506@sirena.org.uk>
References: <1374132753-15206-1-git-send-email-b.brezillon@overkiz.com>
 <1374133720-27362-1-git-send-email-b.brezillon@overkiz.com>
 <20130718095337.GD22506@sirena.org.uk> <51E7C1B2.8000206@overkiz.com>
 <20130718105846.GJ22506@sirena.org.uk>
Message-ID: <51E7D29D.3000008@overkiz.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18/07/2013 12:58, Mark Brown wrote:
> On Thu, Jul 18, 2013 at 12:21:38PM +0200, boris brezillon wrote:
>
>> I can send you the whole series if you want (already sent to LKML
>> and LAKML).
>> But I'd like to understand who I should send patches from this series to.
> When you send me patch 5/5 with no other information on the rest of the
> series I've no idea if there's any dependencies on the other code or
> anything like that.  The key thing here is to make sure the people
> getting the patch can understand the interdependencies somehow.
>
> If you're sending a bunch of unrelated changes with no dependencies
> you're better off sending them all separately rather than as a part of a
> series.
Noted, I will send each patch separately next time (if they are unrelated).
