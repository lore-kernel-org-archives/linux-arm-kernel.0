From: lho@apm.com (Loc Ho)
Date: Wed, 15 Jan 2014 12:04:02 -0800
Subject: [PATCH v9 2/4] Documentation: Add documentation for APM X-Gene
 SoC SATA host controller DTS binding
In-Reply-To: <20140115111839.GB25824@e106331-lin.cambridge.arm.com>
References: <1389769910-15505-1-git-send-email-lho@apm.com>
 <1389769910-15505-2-git-send-email-lho@apm.com>
 <1389769910-15505-3-git-send-email-lho@apm.com>
 <20140115111839.GB25824@e106331-lin.cambridge.arm.com>
Message-ID: <CAPw-ZT=wJVQ2Qw47Ehgu6rJZ4HkpADrGuhZr8Yjf4XA6z+-xbA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

>> +- clocks             : Reference to the clock entry.
>> +- phys                       : PHY reference with parameter 0.
>
> The specific value of the phy-specifier shouldn't matter to this
> binding. What should matter is what it logically corresponds to.

I not quite following this. Are you suggest that I drop the value 0.
In the binding, one needs to specify the mode of operation - 0 is for
SATA. Can you explain more?

-Loc
