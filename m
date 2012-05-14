From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 14 May 2012 18:46:12 +0000
Subject: [PATCH 1/4] ARM: clps711x: Used own subarch directory for store
 header file
In-Reply-To: <1337017571-16208-1-git-send-email-shc_work@mail.ru>
References: <1337017571-16208-1-git-send-email-shc_work@mail.ru>
Message-ID: <201205141846.12491.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 14 May 2012, Alexander Shiyan wrote:
> 
> Patch created for arm-soc clps711x/cleanup branch.
> 
> Signed-off-by: Alexander Shiyan <shc_work@mail.ru>

Hi Alexander,

I've applied these patches to the clps711x/cleanup branch, but I'm
not too happy with the submission form.

Most patches were missing a useful description, which I've had to add
from looking at the contents. In the future I'd expect you to add such
a description yourself, ideally one that explains why you need such a
change, which is something that is not always obvious from the patch
itself.

A comment like "Patch created for arm-soc clps711x/cleanup branch."
is completely meaningless for the changeset description. It should
either go into the [PATCH 0/4] cover letter that git-format-patch
can create for you, or if you send only a single patch, you can put
it between the '---' line and the diffstat, so it appears in the
email but not in the changelog.

Finally, don't send patches just one at a time when you know that
you have more of them. It's annoying for me that I have to go back
to the same branch and merge it repeatedly when you do this. Better
send the entire series at once, or for longer ones, send a git
pull request.

I have not pulled the branches into the main next/cleanup branch,
so they are not yet scheduled for the next merge window (the earlier
two ones are). Let me know whether you have more patches for this series,
I'll put it in once you are done.

	Arnd
