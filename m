From: paul@pwsan.com (Paul Walmsley)
Date: Wed, 29 May 2013 19:06:12 +0000 (UTC)
Subject: [PATCH 0/2] ARM: OMAP AM33XX: clock data: Enable clkout2 output
 on SoC pad
In-Reply-To: <51A35123.6040600@ti.com>
References: <1367919574-21353-1-git-send-email-hvaibhav@ti.com>
 <79CD15C6BA57404B839C016229A409A83EC8C081@DBDE04.ent.ti.com>
 <alpine.DEB.2.00.1305200246080.2656@utopia.booyaka.com>
 <51A35123.6040600@ti.com>
Message-ID: <alpine.DEB.2.02.1305291902450.9052@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Salut Beno?t,

On Mon, 27 May 2013, Benoit Cousson wrote:

> On 05/20/2013 04:47 AM, Paul Walmsley wrote:
> > On Fri, 17 May 2013, Hiremath, Vaibhav wrote:
> > 
> >> Tony, Paul and Benoit,
> >>
> >> Any update on this series?
> > 
> > Most of the changes are DT-related, so it should probably go in via 
> > Beno?t.  I'll ack the clock side, but have a comment on patch 2, to be 
> > sent shortly.
> 
> I've tried to apply that patch, but unfortunately, it does depend on
> that one:
> 
> https://patchwork.kernel.org/patch/2212081/
>
> If you did not already pulled the first one I can take both with your
> acked-by.
> Otherwise, I can take only the DTS ones.
> 
> Is that OK?

Will ack that first patch now.  

Vaibhav, looks like that first series is still in RFC form; you might want 
to repost it as a non-RFC series.


- Paul
