From: tbaicar@codeaurora.org (Tyler Baicar)
Date: Mon, 21 May 2018 16:34:11 -0400
Subject: [PATCH] EDAC, ghes: Make platform-based whitelisting x86-only
In-Reply-To: <20180521171522.GA14289@pd.tnic>
References: <5AF90C70.408@huawei.com> <20180514094709.GC23049@pd.tnic>
 <cb24735c-d251-4dd2-a02f-91e476776824@arm.com>
 <20180514164720.GH23049@pd.tnic>
 <da776696-ddbf-c35e-1dd4-b6e0ce91aed6@arm.com>
 <20180516182958.GB17092@pd.tnic>
 <8602b133-e0fa-57e2-5159-9d34a1ded85f@arm.com>
 <20180518111132.GC17285@pd.tnic> <20180518112028.GD17285@pd.tnic>
 <b1d606dc-527c-6a7d-ce80-a11ac852a5f9@codeaurora.org>
 <20180521171522.GA14289@pd.tnic>
Message-ID: <4ee5f5c3-749d-59de-e753-70bd7fd9411e@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 5/21/2018 1:15 PM, Borislav Petkov wrote:
> On Mon, May 21, 2018 at 09:48:23AM -0400, Tyler Baicar wrote:
>> I don't see an issue with not printing out the long BIOS statement, but the
>> number of DIMM sockets print could still be useful.
> Well, if you wanna dump the number of DIMMs - then maybe that line
> should issue unconditionally. However, "DIMM sockets" is silly - it
> should simply say:
>
> 	"%d DIMMs detected"
>
> or so.
Agreed. Sounds good to me.

-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project.
