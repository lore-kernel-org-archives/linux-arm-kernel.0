From: tsoni@codeaurora.org (Trilok Soni)
Date: Thu, 09 Dec 2010 12:32:57 +0530
Subject: [PATCH] msm: trout: add keypad support
In-Reply-To: <AANLkTikOOH3qHHRtqETytYBk_MiCeVBU724CooUYqgdy@mail.gmail.com>
References: <1291854285-29566-1-git-send-email-dwalker@codeaurora.org>
	<AANLkTikOOH3qHHRtqETytYBk_MiCeVBU724CooUYqgdy@mail.gmail.com>
Message-ID: <4D007F21.5060602@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Abraham,

On 12/9/2010 12:04 PM, Arce, Abraham wrote:
> 
>> +
>> +static unsigned int trout_col_gpios_evt2[] = { 35, 34, 33, 32, 31, 23, 30, 109 };
> 
> WARNING: line over 80 characters

I would leave this to Daniel if he wants to fix it, because by making it under 80 is not
going to improve any code readability, so I prefer to keep it as is.

---Trilok Soni

-- 
Sent by a consultant of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
