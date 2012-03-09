From: B04825@freescale.com (Tabi Timur-B04825)
Date: Fri, 9 Mar 2012 04:03:19 +0000
Subject: [PATCH v3 08/11] ASoC: fsl: make fsl_ssi driver compilable on
 ARM/IMX
In-Reply-To: <20120309032128.GK2499@S2101-09.ap.freescale.net>
References: <1331225990-27308-1-git-send-email-shawn.guo@linaro.org>
 <1331225990-27308-9-git-send-email-shawn.guo@linaro.org>
 <4F5912D0.2090800@freescale.com>
 <20120309012653.GG2499@S2101-09.ap.freescale.net>
 <4F596674.5030405@freescale.com>
 <20120309032128.GK2499@S2101-09.ap.freescale.net>
Message-ID: <4F598106.30300@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Shawn Guo wrote:
> On Fri, Mar 09, 2012 at 02:09:57AM +0000, Tabi Timur-B04825 wrote:
>> >  That's the general idea, but I think it needs more study.  I don't
>> >  consider this to be a bug that needs to be fixed ASAP, since it's never
>> >  been an actual problem so far.  For instance, do we need to protect
>> >  between hw_params and _trigger?
>> >
> Ok, I will leave it to you with a big "FIXME" comment then.

Ok.

-- 
Timur Tabi
Linux kernel developer at Freescale
