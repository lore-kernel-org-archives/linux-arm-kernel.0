From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Thu, 7 Mar 2013 07:09:47 +0800
Subject: [PATCH] cpufreq: ARM big LITTLE: Add generic cpufreq driver and
 its DT glue
In-Reply-To: <20130306172517.GT17833@n2100.arm.linux.org.uk>
References: <f20e3c5e822c4bd28a3b71264d73143cc1f850b0.1362458878.git.viresh.kumar@linaro.org>
 <20130305105251.GL17833@n2100.arm.linux.org.uk>
 <CAKohponef2XNN2i8Dn7aBnzcdJeCmuGrmN3HjaBUZvBHkNSLKQ@mail.gmail.com>
 <20130306172517.GT17833@n2100.arm.linux.org.uk>
Message-ID: <CAKohpo=CZFsj5jQ37rSNtb0A7jX3iZcTqShYwXbGCB=PSjJgeA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 7 March 2013 01:25, Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:
> On Wed, Mar 06, 2013 at 12:38:36AM +0800, Viresh Kumar wrote:
>> So how does below fix look to you?
>
> Much better, but I think you want a better device name than just "clusterN".

I will try to find some other name, maybe cpu-cluster (as what you suggested
initially).

> Also, please get rid of that "default n" - n is the default default default
> default default default.... there's no need to specify it. :)

Ok :)
