From: m.smarduch@samsung.com (Mario Smarduch)
Date: Fri, 14 Nov 2014 10:57:15 -0800
Subject: [PATCH v14 0/7] KVM/arm/x86: dirty page logging for ARMv7
 (3.17.0-rc1)
In-Reply-To: <20141114090659.4ae4f609.cornelia.huck@de.ibm.com>
References: <1415930268-7674-1-git-send-email-m.smarduch@samsung.com>
 <20141114090659.4ae4f609.cornelia.huck@de.ibm.com>
Message-ID: <5466508B.5030302@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/14/2014 12:06 AM, Cornelia Huck wrote:
> On Thu, 13 Nov 2014 17:57:41 -0800
> Mario Smarduch <m.smarduch@samsung.com> wrote:
> 
>> Patch series adds support for ARMv7 and generic dirty page logging support. 
>> As we try to move towards generic dirty page logging additional logic is moved 
>> to generic code. Initially x86, armv7 KVM_GET_DIRTY_LOG reuses generic 
>> code, shortly followed by armv8 patches.
> 
> FWIW: s390 (with qemu/master) seems to work as before.
> 
Hi Cornelia,
  thanks for verifying.

- Mario
