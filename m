From: m.smarduch@samsung.com (Mario Smarduch)
Date: Thu, 28 Aug 2014 12:58:02 -0700
Subject: [PATCH v10 0/6] arm: dirty page logging support for ARMv7
In-Reply-To: <53FF8252.2030304@amd.com>
References: <1409097072-1096-1-git-send-email-m.smarduch@samsung.com>
 <53FF8252.2030304@amd.com>
Message-ID: <53FF89CA.3020608@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/28/2014 12:26 PM, Joel Schopp wrote:
> 
> On 08/26/2014 06:51 PM, Mario Smarduch wrote:
>> This patch adds support for ARMv7 dirty page logging. Some functions
>> of dirty
>> page logging have been split to generic and arch specific
>> implementations,
>> details below. Dirty page logging is one of serveral features required
>> for
>> live migration, live migration has been tested for ARMv7.
> Any reason not to cc the kvm arm list?  I almost missed this patch set. 
> kvmarm at lists.cs.columbia.edu

All previous series were copied to kvm arm list.

This time around email sever setup caused some problems,
including this and few others.

Sorry about that.

- Mario
