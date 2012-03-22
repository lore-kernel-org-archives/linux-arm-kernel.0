From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 22 Mar 2012 12:40:38 -0600
Subject: [PATCH] Kbuild: centralize MKIMAGE and cmd_uimage definitions
In-Reply-To: <1331931835-12346-1-git-send-email-swarren@wwwdotorg.org>
References: <1331931835-12346-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <4F6B7226.8000102@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/16/2012 03:03 PM, Stephen Warren wrote:
> All ARCHs have the same definition of MKIMAGE. Move it to Makefile.lib
> to avoid duplication.
> 
> All ARCHs have similar definitions of cmd_uimage. Place a sufficiently
> parameterized version in Makefile.lib to avoid duplication.

Michal,

Does this change look reasonable? It has acks from people working on 4
of the 7 affected architectures; would you prefer acks from all?

Thanks.
