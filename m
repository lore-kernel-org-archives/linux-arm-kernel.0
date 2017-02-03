From: robert.richter@cavium.com (Robert Richter)
Date: Fri, 3 Feb 2017 16:14:14 +0100
Subject: [PATCH v3] arm64: mm: Fix NOMAP page initialization
In-Reply-To: <20170117191656.GS27328@arm.com>
References: <c74d6ec6-16ba-dccc-3b0d-a8bedcb46dc5@linaro.org>
 <cbbf14fd-a1cc-2463-ba67-acd6d61e9db1@linaro.org>
 <CAKv+Gu8-+0LUTN0+8OGWRhd22Ls5cMQqTJcjKQK_0N=Uc-0jog@mail.gmail.com>
 <20170109115320.GI4930@rric.localdomain>
 <20170112160535.GF13843@arm.com>
 <20170112185825.GE5020@rric.localdomain>
 <20170113091903.GA22538@arm.com>
 <20170113131500.GS4930@rric.localdomain>
 <20170117100015.GG5020@rric.localdomain>
 <20170117191656.GS27328@arm.com>
Message-ID: <20170203151414.GE16822@rric.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17.01.17 19:16:56, Will Deacon wrote:
> I can't really see the trend given that, for system time, your
> pfn_valid_within results have a variance of ~9 and the early_pfn_valid
> results have a variance of ~92. Given that the variance seems to come
> about due to the reboots, I think we need more numbers to establish whether
> the data sets end up largely overlapping or if they really are disjoint.

Assuming the numbers of both versions are not significant, please
apply one or the other.

Thanks,

-Robert
