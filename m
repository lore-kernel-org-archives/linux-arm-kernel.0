From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 21 Nov 2014 16:03:39 -0800
Subject: [RFC 0/2] Qualcomm RPM sleep states
In-Reply-To: <20141121235436.GQ3815@sirena.org.uk>
References: <546FC674.1070005@codeaurora.org>
 <20141121232738.GP3815@sirena.org.uk> <546FCE3A.1000005@codeaurora.org>
 <20141121235436.GQ3815@sirena.org.uk>
Message-ID: <546FD2DB.1020809@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/21/2014 03:54 PM, Mark Brown wrote:
> On Fri, Nov 21, 2014 at 03:43:54PM -0800, Stephen Boyd wrote:
>
>> This sleep set/active set stuff has to do with more than just
>> regulators. It applies to any resource that the RPM provides, but
>> regulators are a primary use case so you're on Cc and it would be great
>> if you fully understood the regulator aspect here.
> Step back: what is the RPM?  Some kind of power management coprocessor
> from the sounds of it?

Yes.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
