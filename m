From: afzal.mohd.ma@gmail.com (afzal mohammed)
Date: Thu, 21 Dec 2017 09:35:26 +0530
Subject: [PATCH] ARM: NOMMU: Setup VBAR/Hivecs for secondaries cores
In-Reply-To: <38fb32ef-9e2f-01c0-c89f-7d05fe8bcf60@arm.com>
References: <1513679029-5915-1-git-send-email-vladimir.murzin@arm.com>
 <20171219112954.GA14910@afzalpc>
 <4e80e47a-d7b4-c09c-fe88-a7dff6522038@arm.com>
 <20171220045219.GA6416@afzalpc>
 <b0e23a0b-8488-b1bc-8afe-cd68e47b9ad6@arm.com>
 <20171220114924.GA5377@afzalpc> <20171220120104.GA5724@afzalpc>
 <38fb32ef-9e2f-01c0-c89f-7d05fe8bcf60@arm.com>
Message-ID: <20171221040526.GC3944@afzalpc>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Vladimir,

On Wed, Dec 20, 2017 at 12:22:38PM +0000, Vladimir Murzin wrote:

> > To add, i am not against your patch, just seeing if we can avoid
> > having this change, lesser code ... lesser bugs.
> 
> Look, I hit that issue and without this change the issue does not
> magically disappear for me - the only way to avoid this change is
> to propose alternative patch.

> I don't want to jump into these "it should not happen" or "nobody"
> cares" discussions just because it is not true - it happened to
> me and I do care. However, I do open to discuss technical aspects.

Okay sir, my reading of your other mail was that you caught this issue
by code inspection and not by hitting the issue in practice, seems
there was a communication gap. Now i am deducing from your mails you
actually have hit some issue because of my change, then your fix is
absolutely required, no question about it.

i was trying to find out the specific scenario where the issue would
be be hit because of my change. But since you are able to fix the
issue in your specific scenario w/ with this fix, no more questions
from my side. Some of my comments are made jokingly to keep the
spirits high, but at times it is being misread it seems.

afzal
