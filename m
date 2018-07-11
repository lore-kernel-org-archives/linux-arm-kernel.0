From: ravi.bangoria@linux.ibm.com (Ravi Bangoria)
Date: Wed, 11 Jul 2018 15:22:32 +0530
Subject: [PATCH v5 06/10] Uprobes: Support SDT markers having reference
 count (semaphore)
In-Reply-To: <6e3ff60b-267a-d49d-4ebb-c4264f9c034b@linux.ibm.com>
References: <20180628052209.13056-1-ravi.bangoria@linux.ibm.com>
 <20180628052209.13056-7-ravi.bangoria@linux.ibm.com>
 <20180701210935.GA14404@redhat.com>
 <0c543791-f3b7-5a4b-f002-e1c76bb430c0@linux.ibm.com>
 <20180702180156.GA31400@redhat.com>
 <f19e3801-d56a-4e34-0acc-1040a071cf91@linux.ibm.com>
 <20180703163645.GA23144@redhat.com> <20180703172543.GC23144@redhat.com>
 <f5a39a88-c21e-4606-a04d-11b5f32016b8@linux.ibm.com>
 <20180710152527.GA3616@redhat.com>
 <6e3ff60b-267a-d49d-4ebb-c4264f9c034b@linux.ibm.com>
Message-ID: <62933fa6-542c-6fc1-354c-51597d5523ef@linux.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Minor correction:

On 07/11/2018 02:14 PM, Ravi Bangoria wrote:
> 
> Third options: How about allowing 0 as a special value for reference
> counter?

s/reference counter/reference counter offset/

 I mean allow uprobe_register() and uprobe_register_refctr()
> in parallel but do not allow two uprobe_register_refctr() with two
> different reference counter.

Ditto.
