From: sudeep.holla@arm.com (Sudeep Holla)
Date: Thu, 11 Oct 2018 17:01:22 +0100
Subject: [PATCH v9 05/11] of: base: Add of_get_cpu_state_node() to get
 idle states for a CPU node
In-Reply-To: <CAPDyKFq7bNJM5Y4y78tnOEvg7ntmYFtJoDvFH8uR2yUUK9o4HA@mail.gmail.com>
References: <20181003143824.13059-1-ulf.hansson@linaro.org>
 <20181003143824.13059-6-ulf.hansson@linaro.org>
 <20181010150331.GB4844@e107155-lin>
 <CAPDyKFq7bNJM5Y4y78tnOEvg7ntmYFtJoDvFH8uR2yUUK9o4HA@mail.gmail.com>
Message-ID: <20181011160122.GB28583@e107155-lin>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 11, 2018 at 05:05:07PM +0200, Ulf Hansson wrote:
> On 10 October 2018 at 17:03, Sudeep Holla <sudeep.holla@arm.com> wrote:
[...]
> >
> > No strong opinion but I am wondering if it makes sense to get cpu
> > logical index and fetch the cpu of_node here to contain the refcount on
> > it within this function while we are trying to consolidate. I do see
> > that may not be so useful in psci.c but keeping refcount for cpu of_node
> > here keeps the user free from that.
> 
> I see your point.
> 
> However, I am hesitating doing that change, as it would be a waste for
> the psci case, but I also think that it may becomes a bit less
> straight forward to use this helper function.
> 
> Although, no strong opinions from my side either, but since Rob is
> happy with this, there is no need to change it, I think.
>

Sure, no problem.

--
Regards,
Sudeep
