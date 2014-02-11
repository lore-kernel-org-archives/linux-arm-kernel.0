From: bryanh@codeaurora.org (Bryan Huntsman)
Date: Tue, 11 Feb 2014 10:10:20 -0800
Subject: [PATCH v3 3/5] ARM: qcom: Split Qualcomm support into legacy
 and multiplatform
In-Reply-To: <392A0D29-65A3-403D-B645-DB74A1897170@codeaurora.org>
References: <1391725484-6673-1-git-send-email-galak@codeaurora.org>
 <1391725484-6673-4-git-send-email-galak@codeaurora.org>
 <20140208032607.GC10784@codeaurora.org>
 <392A0D29-65A3-403D-B645-DB74A1897170@codeaurora.org>
Message-ID: <52FA678C.6050000@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/11/2014 07:13 AM, Kumar Gala wrote:
>>>  *  Copyright (c) 2010, Code Aurora Forum. All rights reserved.
>>> >> + *  Copyright (c) 2014 The Linux Foundation. All rights reserved.
>> > 
>> > We should replace the Code Aurora Forum copyright with Linux
>> > Foundation here.
> Is this something we?ve been doing?  Its normally bad form to make such changes, but I don?t know what the details re when LF took over CAF w/regards to something like Copyright.
> 
> - k

Yes, the line should read:

- *  Copyright (c) 2010, Code Aurora Forum. All rights reserved.
+ *  Copyright (c) 2010,2014 The Linux Foundation. All rights reserved.

-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
