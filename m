From: ravi.bangoria@linux.ibm.com (Ravi Bangoria)
Date: Tue, 3 Jul 2018 13:41:09 +0530
Subject: [PATCH v5 06/10] Uprobes: Support SDT markers having reference
 count (semaphore)
In-Reply-To: <f19e3801-d56a-4e34-0acc-1040a071cf91@linux.ibm.com>
References: <20180628052209.13056-1-ravi.bangoria@linux.ibm.com>
 <20180628052209.13056-7-ravi.bangoria@linux.ibm.com>
 <20180701210935.GA14404@redhat.com>
 <0c543791-f3b7-5a4b-f002-e1c76bb430c0@linux.ibm.com>
 <20180702180156.GA31400@redhat.com>
 <f19e3801-d56a-4e34-0acc-1040a071cf91@linux.ibm.com>
Message-ID: <21a40b31-8b2d-7645-70aa-4168d4a5d094@linux.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 07/03/2018 11:00 AM, Ravi Bangoria wrote:
> In short, if I put it inside install_breakpoint()/remove_breakpoint(),
> I'll have to put the same logic there with more complication to
> increment / decrement counter for each consumer. And additionally,
> I've to maintain sdt_mm_list to make sure increment and decrement
> happen in sync. With current approach, this all happens by default :)

s/this all happens by default/no need to maintain all this/

-Ravi
