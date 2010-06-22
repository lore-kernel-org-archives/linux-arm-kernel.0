From: eric.y.miao@gmail.com (Eric Miao)
Date: Tue, 22 Jun 2010 11:05:07 +0800
Subject: [PATCH 2/3] [ARM] pxa: remove useless NODE_MEM_SIZE_BITS
In-Reply-To: <20100621182219.GB13624@n2100.arm.linux.org.uk>
References: <1277130154-25912-1-git-send-email-eric.y.miao@gmail.com>
	<1277130154-25912-2-git-send-email-eric.y.miao@gmail.com>
	<20100621182219.GB13624@n2100.arm.linux.org.uk>
Message-ID: <AANLkTikx9dbpPKk1D7yTH0ypVsrY5fRZPekPQoOOSnsm@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 22, 2010 at 2:22 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Mon, Jun 21, 2010 at 10:22:33PM +0800, Eric Miao wrote:
>> As DISCONTIGMEM is not enabled on PXA, remove this useless bit.
>
> You need to look at my LMB or devel branch. ?This is gone already there.
>

Excellent, wanting this removed for a long time. I'll keep eyes more on
those bits now.
