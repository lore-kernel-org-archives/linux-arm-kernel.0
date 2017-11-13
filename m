From: santosh.shilimkar@oracle.com (Santosh Shilimkar)
Date: Mon, 13 Nov 2017 10:04:09 -0800
Subject: [PATCHv3 2/3] EDAC: ti: add support for TI keystone and DRA7xx
 EDAC
In-Reply-To: <20171113175816.qmvbug4kf3qu5meq@pd.tnic>
References: <1510087139-21885-3-git-send-email-t-kristo@ti.com>
 <1510578490-14510-1-git-send-email-t-kristo@ti.com>
 <47e1810b-a10b-28fb-ba0e-fe28ae337c61@oracle.com>
 <20171113175816.qmvbug4kf3qu5meq@pd.tnic>
Message-ID: <f9d1b261-7942-6ff6-bfc3-4b3ff22f0e27@oracle.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/13/2017 9:58 AM, Borislav Petkov wrote:
> On Mon, Nov 13, 2017 at 09:10:09AM -0800, Santosh Shilimkar wrote:
>> Once you have driver queued up, please post DTS patches
>> separately. Will queue them up.
> 
> It would be easier if you ACK the DTS patches and I can pick all three
> up after the merge window is over. This way they go together and there's
> no inter-tree dependency.
> 
That doesn't help and not an usual workflow.
DTS patches actually conflict and they better go through arch port.
Let the driver get merged which has no dependency with DTS patches
instead of waiting for merge window being over. DTS patches can be
merged anytime once its respective driver are in tree.

Regards,
Santosh
