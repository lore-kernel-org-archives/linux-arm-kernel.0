From: olof@lixom.net (Olof Johansson)
Date: Tue, 18 Jun 2013 00:29:57 -0700
Subject: [PATCH] ARM: dts: msm: Fix merge resolution
In-Reply-To: <1371501578-24484-1-git-send-email-davidb@codeaurora.org>
References: <1371501578-24484-1-git-send-email-davidb@codeaurora.org>
Message-ID: <20130618072957.GC21138@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 17, 2013 at 01:39:38PM -0700, David Brown wrote:
> Commit e45600107b (Merge tag 'msm-cleanup-for-3.11' of
> git://git.kernel.org/pub/scm/linux/kernel/git/davidb/linux-msm into
> next/cleanup) incorrectly resolved a merge conflict, resulting in a
> node address that doesn't match the register address.
> 
> Fix this node address.

Luckily this is just cosmetic. Applied.


-Olof
