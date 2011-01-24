From: davidb@codeaurora.org (David Brown)
Date: Mon, 24 Jan 2011 14:13:07 -0800
Subject: [PATCH v2 07/11] msm: Add MSM 8960 cpu_is check
In-Reply-To: <1295904928.29639.58.camel@c-dwalke-linux.qualcomm.com> (Daniel
	Walker's message of "Mon, 24 Jan 2011 13:35:28 -0800")
References: <1292384961-8851-1-git-send-email-stepanm@codeaurora.org>
	<1295468747-22796-1-git-send-email-davidb@codeaurora.org>
	<1295468747-22796-8-git-send-email-davidb@codeaurora.org>
	<1295901976.29639.53.camel@c-dwalke-linux.qualcomm.com>
	<8yak4hukn00.fsf@huya.qualcomm.com>
	<1295904928.29639.58.camel@c-dwalke-linux.qualcomm.com>
Message-ID: <8ya8vyakl1o.fsf@huya.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 24 2011, Daniel Walker wrote:

>> What do you want me to call it?
>> 
>>   #define cpu_is_97d0c886-3768-4998-8925-16f36209d0d1()
>
> I want you to call it msm8x60 ..

msm8960 is not a subset of msm8x60.  It's just a misleading name.  It's
a very different device, and needs it's own identifier.

David

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
