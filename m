From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon, 20 Dec 2010 13:52:46 -0800
Subject: [PATCH 1/3] hvc_dcc: Fix bad code generation by marking assembly
	volatile
In-Reply-To: <AANLkTi=8F3keaAQ2o+V8gNncNM02c9k9=DRtd5GyP_LH@mail.gmail.com>
References: <1292649385-28771-1-git-send-email-sboyd@codeaurora.org>	<1292875718-7980-1-git-send-email-sboyd@codeaurora.org>	<1292875718-7980-2-git-send-email-sboyd@codeaurora.org>
	<AANLkTi=8F3keaAQ2o+V8gNncNM02c9k9=DRtd5GyP_LH@mail.gmail.com>
Message-ID: <4D0FD02E.3080901@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/20/2010 01:49 PM, Arnaud Lacombe wrote:
> Hi,
>
> On Mon, Dec 20, 2010 at 3:08 PM, Stephen Boyd <sboyd@codeaurora.org> wrote:
>> Without marking the asm __dcc_getstatus() volatile my compiler
>> decides [...]
> What compiler ? That might be a usefull information to know,
> espectially 5 years from now when tracing code history. There has been
> similar issue with gcc 4.5 recently. AFAIK, in the same idea, the
> final change has been to mark the asm volatile.

Sure, we can replace "my compiler" with "my compiler (arm-eabi-gcc (GCC)
4.4.0)".

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
