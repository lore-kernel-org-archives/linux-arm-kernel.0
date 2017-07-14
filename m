From: dingtianhong@huawei.com (Ding Tianhong)
Date: Fri, 14 Jul 2017 18:23:51 +0800
Subject: [PATCH v7 3/3] net/cxgb4: Use new
 PCI_DEV_FLAGS_NO_RELAXED_ORDERING flag
In-Reply-To: <MWHPR12MB1600E5A4404EE9D97CD99F88C8AC0@MWHPR12MB1600.namprd12.prod.outlook.com>
References: <1499955692-26556-1-git-send-email-dingtianhong@huawei.com>
 <1499955692-26556-4-git-send-email-dingtianhong@huawei.com>
 <CAKgT0UcBFBk9T7g0Dh-rHY6Z+6-4=5jsUWHbLcSMc+ohdTz=CA@mail.gmail.com>
 <CAKgT0Uf8Tg6AFthXt-bJrdNHCqJ3MfzduR1yCMMsjLYoEFXb-w@mail.gmail.com>
 <MWHPR12MB1600E5A4404EE9D97CD99F88C8AC0@MWHPR12MB1600.namprd12.prod.outlook.com>
Message-ID: <d36574a1-2853-6989-25ae-5fd1b0d811ba@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Casey, Alexander:

Thanks for the great efforts from both of you, It looks like we have reached a consensus finally,
could you please add a confirmation message just like Reviewed-by or something else, thanks. :)

Ding

On 2017/7/14 2:44, Casey Leedom wrote:
>   Yeah, I think this works for now.  We'll stumble over what to do when we want to mix upstream TLPs without Relaxed Ordering Attributes directed at problematic Root Complexes, and Peer-to-Peer TLPs with Relaxed Ordering Attributes ... or vice versa depending on which target PCIe Device has issues with Relaxed Ordering.
> 
> 
>   Thanks for all the work!
> 
> 
> Casey
> 
> 
