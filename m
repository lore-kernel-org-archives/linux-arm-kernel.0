From: davidb@codeaurora.org (David Brown)
Date: Mon, 24 Jan 2011 14:49:20 -0800
Subject: [PATCH v2 06/11] msm: irqs-8960: Interrupt map for MSM8960
In-Reply-To: <1295909142.29639.63.camel@c-dwalke-linux.qualcomm.com> (Daniel
	Walker's message of "Mon, 24 Jan 2011 14:45:42 -0800")
References: <1292384961-8851-1-git-send-email-stepanm@codeaurora.org>
	<1295468747-22796-1-git-send-email-davidb@codeaurora.org>
	<1295468747-22796-7-git-send-email-davidb@codeaurora.org>
	<1295909142.29639.63.camel@c-dwalke-linux.qualcomm.com>
Message-ID: <8yaaaipkjdb.fsf@huya.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 24 2011, Daniel Walker wrote:

> On Wed, 2011-01-19 at 12:25 -0800, David Brown wrote:
>> +#define SC_AVSCPUXUP                           (GIC_PPI_START + 12)
>> +#define SC_SICCPUXACGIRPTREQ                   (GIC_PPI_START + 13)
>> +#define SC_SICCPUXEXTFAULTIRPTREQ              (GIC_PPI_START + 14)
>> +/* PPI 15 is unused */ 
>
> How are you handling this at runtime?

We're not yet.  That's why it is marked as a TODO.

David

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
