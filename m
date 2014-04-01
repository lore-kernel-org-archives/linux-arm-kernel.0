From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 01 Apr 2014 14:18:47 -0600
Subject: [PATCH 1/2] ARM: add cpu_is_pj4() to distinguish PJ4 core
In-Reply-To: <1395385319-25386-1-git-send-email-chao.xie@marvell.com>
References: <1395385319-25386-1-git-send-email-chao.xie@marvell.com>
Message-ID: <533B1F27.9010504@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/21/2014 01:01 AM, Chao Xie wrote:
> PJ4 is based on V7, but it has some changes. For example, some
> coprocessor settings.

I don't see this patch in linux-next, yet I think the runtime problem
has gone away somehow. How did that happen?
