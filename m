From: jcm@redhat.com (Jon Masters)
Date: Wed, 17 Sep 2014 04:58:10 -0400
Subject: [PATCH v4 18/18] Documentation: ACPI for ARM64
In-Reply-To: <20140917014410.GC31214@srcf.ucam.org>
References: <1410530416-30200-1-git-send-email-hanjun.guo@linaro.org>
 <1410530416-30200-19-git-send-email-hanjun.guo@linaro.org>
 <20140917014410.GC31214@srcf.ucam.org>
Message-ID: <54194D22.7060706@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/16/2014 09:44 PM, Matthew Garrett wrote:
> On Fri, Sep 12, 2014 at 10:00:16PM +0800, Hanjun Guo wrote:
> 
>> +Common _DSD bindings should be submitted to ASWG to be included in the
>> +document :-
>> +
>> +http://www.uefi.org/sites/default/files/resources/_DSD-implementation-guide-toplevel.htm
> 
> How are individuals/companies who aren't UEFI members supposed to do 
> this? Aren't there IP issues involved in taking submissions from 
> non-members?

Obviously, I'm not a lawyer, but I would note that the _DSD bindings
aren't going into the core ACPI document. I think the specifics for non
members of the UEFI to potentially contribute bindings need to be
addressed. That said, at this point, the population of the UEFI forum is
very well aligned with initial players (that this is the case is not
entirely an accident, I went around to a few folks a year or so ago and
made sure that they had become members in anticipation of this issue).

Jon.
