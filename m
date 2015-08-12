From: caschebe@techfak.uni-bielefeld.de (Christian Ascheberg)
Date: Wed, 12 Aug 2015 11:27:35 +0200
Subject: Problem with ftrace uprobes on ARM
In-Reply-To: <20150810193116.GA2895@debian>
References: <55C8E417.7080607@techfak.uni-bielefeld.de>
 <20150810193116.GA2895@debian>
Message-ID: <55CB1187.6030301@techfak.uni-bielefeld.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thanks, your answer was really helpful. I did not know that Thumb 
instructions were not supported, which solved my initial problem when 
using Perf as well.

Is there any documentation regarding limitations of perf/ftrace support 
on ARM (compared to x86)?

For example, I also noticed that 'perf help' lists 'trace' command, but 
running 'perf trace' says 'is not a perf-command'.
