From: sudeep.holla@arm.com (Sudeep Holla)
Date: Wed, 17 Jan 2018 18:00:34 +0000
Subject: [PATCH v6 05/12] ACPI/PPTT: Add Processor Properties Topology
 Table parsing
In-Reply-To: <096cdff0-d160-68ba-4cd2-0691dd04eac6@arm.com>
References: <20180113005920.28658-1-jeremy.linton@arm.com>
 <20180113005920.28658-6-jeremy.linton@arm.com>
 <20180115154813.GB17664@e107155-lin>
 <096cdff0-d160-68ba-4cd2-0691dd04eac6@arm.com>
Message-ID: <caa1bb6b-7338-a9b0-467e-d0cd09783a9c@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 16/01/18 20:22, Jeremy Linton wrote:
> Hi,
> 

[..]

>>
>> I forgot to mention this earlier, I see you have used parentheses too
>> liberally at quite some place in this file like the above 4 line.
>> Please drop those unnecessary parentheses.
> 
> Yes, those tend to get leftover when I remove code, I realized not long
> after posting this that in one of the previous patches I actually added
> a pair where there wasn't one because I first shuffled something into
> the if condition, then a few revisions later dropped it, and when I
> squashed it before posting the result was some pointless churn.
> 
> I will rescan the whole set for this.
> 

Better, just to avoid keeping such things until the end, resulting in
churning up series just for that.

-- 
Regards,
Sudeep
