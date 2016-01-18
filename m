From: steve.muckle@linaro.org (Steve Muckle)
Date: Mon, 18 Jan 2016 11:25:41 -0800
Subject: [RFC PATCH v2 0/4] CPUs capacity information for heterogeneous
 systems
In-Reply-To: <20160118151316.GD7159@e106622-lin>
References: <1452262172-31861-1-git-send-email-juri.lelli@arm.com>
 <56994D87.6000709@linaro.org> <20160118151316.GD7159@e106622-lin>
Message-ID: <569D3C35.5070703@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/18/2016 07:13 AM, Juri Lelli wrote:
>> DT solves these issues and would be the perfect place for this - we are
>> > defining the compute capacity of a CPU which is a property of the
>> > hardware. However there are a couple things forcing us to compromise.
>> > One is that the amount and detail of information required to adequately
>> > capture the computational abilities of a CPU across all possible
>> > workloads seem onerous to collect and enumerate. The second is that even
>> > if we were willing to undertake that, CPU vendors probably won't be
>> > forthcoming with that information.
>> > 
>
> You mean because they won't publish performance data of their hw?

More specific things like IPC and other architectural details that could
comprise a precise physical definition of a CPU that would meet the
ideal goals of a device tree definition.

> But we already use per platform normalized values (as you are proposing
> below). So that a platform to platform comparison doesn't make sense.

Yeah I'm just advocating for that strategy here.

cheers,
Steve
