From: grant.likely@secretlab.ca (Grant Likely)
Date: Wed, 1 Feb 2012 11:06:04 -0700
Subject: [PATCH v3 22/25] irq_domain/x86: Convert x86 (embedded) to use
 common irq_domain
In-Reply-To: <20120201141705.GF9587@linutronix.de>
References: <1327700179-17454-1-git-send-email-grant.likely@secretlab.ca>
 <1327700179-17454-23-git-send-email-grant.likely@secretlab.ca>
 <20120128164405.GA20763@linutronix.de>
 <20120130195842.GT28397@ponder.secretlab.ca>
 <20120201141705.GF9587@linutronix.de>
Message-ID: <CACxGe6vZxWXUG-WJFWDaoH3+PYBGWOXb291_jn9TdjrSF=p_JQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 1, 2012 at 7:17 AM, Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
> * Grant Likely | 2012-01-30 12:58:42 [-0700]:
>
>>Ugh. ?This isn't easy. ?The legacy mapping really needs all the
>
> Feel free to merge this patch. I don't have the time to look at this now
> so I take a look at the ioapic later.

There's no rush here.  I can leave it as-is with IRQ_DOMAIN turned off
for x86 for now.

g.
