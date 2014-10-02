From: mmarek@suse.cz (Michal Marek)
Date: Thu, 02 Oct 2014 15:11:05 +0200
Subject: [PATCH] kbuild: arm: Do not define "comma" twice
In-Reply-To: <1408704737-16973-1-git-send-email-yamada.m@jp.panasonic.com>
References: <1408704737-16973-1-git-send-email-yamada.m@jp.panasonic.com>
Message-ID: <542D4EE9.4010003@suse.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2014-08-22 12:52, Masahiro Yamada wrote:
> The definition of "comma" exists in scripts/Kbuild.include.
> We should not double it.
> 
> Signed-off-by: Masahiro Yamada <yamada.m@jp.panasonic.com>
> Cc: linux-arm-kernel at lists.infradead.org

I do not see the patch in linux-next, so I applied it to the kbuild tree.

Michal
