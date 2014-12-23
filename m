From: jagannadh.teki@gmail.com (Jagan Teki)
Date: Tue, 23 Dec 2014 15:45:47 +0530
Subject: ARM64 Crypto validation
Message-ID: <CAD6G_RRFU_R6SHvc5C785qtJ1GTt_-HXhn83xXOxc=VAwPjdqQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I need some information to validate arm64/crypto, do we have any
exact/defined way to validate this.

Here are my findings:
1. I see a dirty test module tcrypto.c where we need to give the sec
and mode module params as inputs.
2. Validate through open crypto [1]

Do we have any arm64 specific validations, Request for help.

[1] http://sourceforge.net/projects/ocf-linux/

thanks!
-- 
Jagan.
