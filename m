From: chris.brand@broadcom.com (Chris (Christopher) Brand)
Date: Tue, 28 Jul 2015 19:39:57 +0000
Subject: [Xen-devel] [PATCH 4/8] xen: Use the correctly the Xen memory
 terminologies
In-Reply-To: <1438095769-2560-5-git-send-email-julien.grall@citrix.com>
References: <1438095769-2560-1-git-send-email-julien.grall@citrix.com>
 <1438095769-2560-5-git-send-email-julien.grall@citrix.com>
Message-ID: <4EE5B48738DDED408878C97C8E050A8B1D7DDBB5@SJEXCHMB05.corp.ad.broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Based on include/xen/mm.h [1], Linux is mistakenly using MFN when GFN is meant,
> I suspect this is because the first support for Xen was for PV. This brough some
Typo : "brought"
Perhaps "resulted in" would be better ?

> misimplementation of helpers on ARM and make the developper confused the expected behavior.
Typo: "developer".
I'd also suggest "...and confused developers about the...".

[...]

> For clarity and avoid new confusion, replace any reference of mfn into gnf in any helpers used by PV drivers.
Typo : "gfn"
I'd suggest "...replace any reference to mfn with gfn..."

[...]

Chris
