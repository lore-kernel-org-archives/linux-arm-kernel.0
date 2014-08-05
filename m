From: bpringlemeir@nbsps.com (Bill Pringlemeir)
Date: Tue, 05 Aug 2014 13:39:20 -0400
Subject: [PATCH 1/2] ARM: dts: vf610-twr: Fix pinctrl_esdhc1 pin
 definitions.
In-Reply-To: <1407260041-19234-2-git-send-email-bpringlemeir@nbsps.com> (Bill
 Pringlemeir's message of "Tue, 5 Aug 2014 13:34:00 -0400")
References: <1407260041-19234-1-git-send-email-bpringlemeir@nbsps.com>
 <1407260041-19234-2-git-send-email-bpringlemeir@nbsps.com>
Message-ID: <87tx5q7s53.fsf@nbsps.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On  5 Aug 2014, bpringlemeir at nbsps.com wrote:

> Previous version had an extra 'fsl' which made the pins not match
> any entry.  The console message,

All patches are based off 'for-next' (5424d6fd) in,

 git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git

Thanks,
Bill Pringlemeir.
