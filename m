From: tom.leiming@gmail.com (Ming Lei)
Date: Thu, 11 Nov 2010 18:03:35 +0800
Subject: [Questions] How to run 'perf top' on ARM to profile kernel
	functions with modules loaded
In-Reply-To: <AANLkTimXfstwyBzoXjY=iX+QBQSswy4_Rq5TjApqkYqJ@mail.gmail.com>
References: <AANLkTinwAL8dFsDbd-ZTQEcEziq6jZk82KPzNqMVxnOx@mail.gmail.com>
	<AANLkTim+BAYKWqiJzSQQLc4e_yNkMsNNnEp5u8YgC2Fk@mail.gmail.com>
	<AANLkTimXfstwyBzoXjY=iX+QBQSswy4_Rq5TjApqkYqJ@mail.gmail.com>
Message-ID: <AANLkTin7SxDU0c6yWWfR8yF2dUmM7NE9EViPXA03a0Cs@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>2010/11/11 Ingo Molnar <mingo@elte.hu>:
> Must be some bug in the ELF symbol handling code - we've had many cases of quirks
> and special cases there. Please run 'perf archive' and send the resulting
> perf.data.tar.bz2 to Arnaldo in private mail. (the file will be big)

Sent to Arnaldo already.

2010/11/11 Kyungmin Park <kmpark@infradead.org>:
>
> I tried to build the perf as static and build success on ARM. But
> there's no display and no top results also.
> How do you build the perf on ARM? any hints or clues?

Cross-compiling perf tool is very painful, so I choose to compile
perf in Angstom on beagle-xm(ARM) directly, isn't it fun? :-)

thanks,
-- 
Lei Ming
