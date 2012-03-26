From: mmarek@suse.cz (Michal Marek)
Date: Mon, 26 Mar 2012 15:48:42 +0200
Subject: [PATCH] Kbuild: centralize MKIMAGE and cmd_uimage definitions
In-Reply-To: <4F6B7226.8000102@wwwdotorg.org>
References: <1331931835-12346-1-git-send-email-swarren@wwwdotorg.org>
 <4F6B7226.8000102@wwwdotorg.org>
Message-ID: <4F7073BA.6040403@suse.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 22.3.2012 19:40, Stephen Warren wrote:
> On 03/16/2012 03:03 PM, Stephen Warren wrote:
>> All ARCHs have the same definition of MKIMAGE. Move it to Makefile.lib
>> to avoid duplication.
>>
>> All ARCHs have similar definitions of cmd_uimage. Place a sufficiently
>> parameterized version in Makefile.lib to avoid duplication.
> 
> Michal,
> 
> Does this change look reasonable?

Absolutely.

> It has acks from people working on 4
> of the 7 affected architectures; would you prefer acks from all?

I will apply it now.

Michal
