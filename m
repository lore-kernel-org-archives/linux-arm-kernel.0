From: okaya@codeaurora.org (Sinan Kaya)
Date: Fri, 21 Apr 2017 09:50:23 -0400
Subject: [PATCH V8 4/5] PCI/ASPM: save power on values during bridge init
In-Reply-To: <92EBB4272BF81E4089A7126EC1E7B2846676C7EF@IRSMSX101.ger.corp.intel.com>
References: <1491627351-1111-1-git-send-email-okaya@codeaurora.org>
 <1491627351-1111-5-git-send-email-okaya@codeaurora.org>
 <CACK8Z6GXfMWxakNQnvMToig9z9McnJKeYFc2BAAFy7ys8=PUWg@mail.gmail.com>
 <d3857812-7e03-4b62-f7cb-ac0d139b6123@codeaurora.org>
 <20170414214452.GA21870@bhelgaas-glaptop.roam.corp.google.com>
 <66168dde-7719-6f74-3f06-8e4724dd2918@codeaurora.org>
 <CAErSpo7p_2dTDTC7J4HdQUw_5GH8081dUZ=XVqd=sRLrA_FJnA@mail.gmail.com>
 <c0c2f48f-d725-058e-a1ad-92ab4b6e7fb3@codeaurora.org>
 <92EBB4272BF81E4089A7126EC1E7B2846676C7EF@IRSMSX101.ger.corp.intel.com>
Message-ID: <16c80ef9-8928-b7c9-dc6e-f1c96efb6da3@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4/21/2017 3:46 AM, Patel, Mayurkumar wrote:
> If we want to follow above approach then shall we consider having something similar as following?

Do you see this problem if you boot with pcie_aspm.policy=powersave option?


-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
