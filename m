From: xerofoify@gmail.com (Nicholas Krause)
Date: Wed, 20 May 2015 14:10:36 -0400
Subject: [PATCH RESEND] mach-omap2:Remove calls to deprecacted marco,
 PTR_RET in the files, fb.c and pmu.c
In-Reply-To: <20150520180703.GI10274@atomide.com>
References: <1431958079-486-1-git-send-email-xerofoify@gmail.com>
 <20150520180703.GI10274@atomide.com>
Message-ID: <4C6EB19A-6533-40E9-AD8B-CF0B9CB69D91@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On May 20, 2015 2:07:03 PM EDT, Tony Lindgren <tony@atomide.com> wrote:
>* Nicholas Krause <xerofoify@gmail.com> [150518 07:09]:
>> This removes two calls to the deprecated marco,PTR_RET in
>> the files,fb.c and pmu.c for the functions,omap_init_vrfb
>> and omap_init_pmu respectfully. Furthermore these are now
>> replaced by calling the correctly non deprecacted function,
>> PTR_ERR_OR_ZERO in both functions.
>
>I've applied the original version today as they seem to be
>the same.
>
>Thanks,
>
>Tony
That's fine.  I just resent due to the rule about resending after a week. 
Nick

-- 
Sent from my Android device with K-9 Mail. Please excuse my brevity.
