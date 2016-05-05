From: timur@codeaurora.org (Timur Tabi)
Date: Thu, 5 May 2016 13:22:10 -0500
Subject: [PATCH RFC] Watchdog: sbsa_gwdt: Enhance timeout range
In-Reply-To: <20160505182031.GB12434@dhcppc6.redhat.com>
References: <5728A7C3.4010001@roeck-us.net>
 <20160503143856.GE13045@dhcppc6.redhat.com> <5728BEC4.6050603@codeaurora.org>
 <20160503155141.GF13045@dhcppc6.redhat.com>
 <20160503171602.GA2518@roeck-us.net>
 <20160504141449.GG13045@dhcppc6.redhat.com> <572A0577.1070000@codeaurora.org>
 <20160504155932.GH13045@dhcppc6.redhat.com> <572A2099.4070901@codeaurora.org>
 <20160505164300.GA16914@roeck-us.net>
 <20160505182031.GB12434@dhcppc6.redhat.com>
Message-ID: <572B8F52.2000709@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Pratyush Anand wrote:
> I think, in the long run we must have SBSA
> watchdog specification improvement to keep WOR as 64 bit.

I agree with this 100%.  IMHO, using a 32-bit WOR was just a bad decision.

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora
Forum, a Linux Foundation collaborative project.
