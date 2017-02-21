From: sudeep.holla@arm.com (Sudeep Holla)
Date: Tue, 21 Feb 2017 13:53:00 +0000
Subject: [PATCH] arm64: dts: juno: update definition for programmable
 replicator.
In-Reply-To: <CAJ9a7VhKtS-nrSBWQzMWkO1E1BajZY2aGBurdRAB05tGy2xs9A@mail.gmail.com>
References: <1487358790-2618-1-git-send-email-mike.leach@linaro.org>
 <2ba59da5-fc79-ab53-2f2a-2ddc6e5e9c3d@arm.com>
 <DB6PR0802MB219850A35C8DAD5CB2858C1C8C510@DB6PR0802MB2198.eurprd08.prod.outlook.com>
 <798053cd-ae5a-dc04-12c9-9df9e0d66b4d@arm.com>
 <CAJ9a7VhKtS-nrSBWQzMWkO1E1BajZY2aGBurdRAB05tGy2xs9A@mail.gmail.com>
Message-ID: <2c0e2e3a-f852-7184-036f-536d94e80c23@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mike,

On 21/02/17 12:46, Mike Leach wrote:
> The messages are not a normal linux / kernel warning message, but a
> result of the offline trace decode process:-
> 
>   110739: I_OVERFLOW : Overflow.
>   110741: I_ASYNC : Alignment Synchronisation.
>   110754: I_TRACE_INFO : Trace Info.; PCTL=0x0
>   110757: I_TRACE_ON : Trace On.
> 
> If this is sufficient with an explanation I'm happy to add it to the patch.
> 

Oh OK, then no need to add to changelog as it requires the knowledge of
this tool to understand which is not part of the kernel tree. I will try
to push it as a fix and lets see how that goes.

-- 
Regards,
Sudeep
