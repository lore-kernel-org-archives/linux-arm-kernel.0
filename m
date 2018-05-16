From: kim.phillips@arm.com (Kim Phillips)
Date: Wed, 16 May 2018 15:24:58 -0500
Subject: [PATCH v2] coresight: documentation: update sysfs section
In-Reply-To: <20180516131823.4b1a3ecb@lwn.net>
References: <20180507172915.c032cd71c07b1849bf419a5f@arm.com>
 <CANLsYkyQLan3XajOz2uuoOF8OQchGfeu2ZkZJ9H1Xm9q==aXTw@mail.gmail.com>
 <20180514121959.a9a3d2fb3d3d270849ffbc39@arm.com>
 <20180516131823.4b1a3ecb@lwn.net>
Message-ID: <20180516152458.d392b0d1e09393da30e2aeb6@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 16 May 2018 13:18:23 -0600
Jonathan Corbet <corbet@lwn.net> wrote:

> On Mon, 14 May 2018 12:19:59 -0500
> Kim Phillips <kim.phillips@arm.com> wrote:
> 
> > - Align and show updated ls devices output from the TC2, based on
> >   current driver
> > 
> > - Provide an example from an ETMv4 based system (Juno)
> > 
> > - Reflect changes to the way the RAM write pointer is accessed since
> >   it got changed in commit 7d83d17795ef ("coresight: tmc: adding sysFS
> >   management entries").
> 
> So I was going to apply this, but it's been pretty badly corrupted by
> your mailer.  Could I ask you to retry, please?

I had sent a v3 that corrected the issue, in the same thread, here:

https://lkml.org/lkml/2018/5/14/1190

Mathieu acked that one.

Thanks,

Kim
