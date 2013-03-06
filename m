From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 6 Mar 2013 17:25:17 +0000
Subject: [PATCH] cpufreq: ARM big LITTLE: Add generic cpufreq driver
 and its DT glue
In-Reply-To: <CAKohponef2XNN2i8Dn7aBnzcdJeCmuGrmN3HjaBUZvBHkNSLKQ@mail.gmail.com>
References: <f20e3c5e822c4bd28a3b71264d73143cc1f850b0.1362458878.git.viresh.kumar@linaro.org>
 <20130305105251.GL17833@n2100.arm.linux.org.uk>
 <CAKohponef2XNN2i8Dn7aBnzcdJeCmuGrmN3HjaBUZvBHkNSLKQ@mail.gmail.com>
Message-ID: <20130306172517.GT17833@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 06, 2013 at 12:38:36AM +0800, Viresh Kumar wrote:
> So how does below fix look to you?

Much better, but I think you want a better device name than just "clusterN".

Also, please get rid of that "default n" - n is the default default default
default default default.... there's no need to specify it. :)
