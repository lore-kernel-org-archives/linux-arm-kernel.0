From: will.deacon@arm.com (Will Deacon)
Date: Mon, 18 Apr 2011 18:57:40 +0100
Subject: [PATCH 4/6] ARM: msm: update GPIO chained IRQ handler to use
	entry/exit functions
In-Reply-To: <8yazknr1iaq.fsf@huya.qualcomm.com>
References: <1302633340-4795-1-git-send-email-will.deacon@arm.com>
	<1302633340-4795-5-git-send-email-will.deacon@arm.com>
	<8yazknr1iaq.fsf@huya.qualcomm.com>
Message-ID: <1303149460.13157.17.camel@e102144-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

David,

On Fri, 2011-04-15 at 19:27 +0100, David Brown wrote:
> On Tue, Apr 12 2011, Will Deacon wrote:
> 
> > This patch updates the MSM gpio chained IRQ handler to use the chained
> > IRQ enter/exit functions in order to function correctly on primary
> > controllers with different methods of flow control.
> >
> > Cc: Abhijeet Dharmapurikar <adharmap@codeaurora.org>
> > Signed-off-by: Will Deacon <will.deacon@arm.com>
> 
> I'm okay acking this as long as Abhijeet is ok with it.

Ok, I'll add your Ack to this guy now that Abhijeet has tested/reviewed
it.

Thanks,

Will
