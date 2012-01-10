From: khilman@ti.com (Kevin Hilman)
Date: Tue, 10 Jan 2012 09:47:26 -0800
Subject: [PATCHV2 REPOST 5/7] ARM: OMAP3PLUS PM: Add IO Daisychain support
 via hwmod mux
In-Reply-To: <8739bnsb6o.fsf@ti.com>
References: <1323878477-21122-1-git-send-email-vishwanath.bs@ti.com>
 <1323878477-21122-6-git-send-email-vishwanath.bs@ti.com>
 <8739bnsb6o.fsf@ti.com>
Message-ID: <4F0C79AE.308@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/10/2012 09:46 AM, Kevin Hilman wrote:
> Vishwanath BS<vishwanath.bs@ti.com>  writes:
>
>> >  IO Daisychain feature has to be triggered whenever there is a change in
>> >  device's mux configuration (See section 3.9.4 in OMAP4 Public TRM vP).
 >
> ...in addition to the triggering still happening in the idle path,
> right?   IIUC, after this series, there's still a call in omap_sram_idle().

oops, please ignore this comment.  I see the answer in PATCH 6/7.

Sorry for the noise.

Kevin
