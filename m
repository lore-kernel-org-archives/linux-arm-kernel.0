From: p.pisati@gmail.com (Paolo Pisati)
Date: Wed, 28 Feb 2018 17:15:07 +0100
Subject: Internal error: Oops - BUG() / kvm boot race - arm64 kpti
 patchset related
In-Reply-To: <64e691b2-24be-ef7c-3b31-619e6b373a52@arm.com>
References: <20180228154523.GA29931@akinoame>
 <64e691b2-24be-ef7c-3b31-619e6b373a52@arm.com>
Message-ID: <20180228161507.GC31013@akinoame>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 28, 2018 at 03:51:55PM +0000, Marc Zyngier wrote:
> 
> What HW are you using? Your command line? Your configuration? How are
> you rebooting your guest (to EFI? directly to the kernel itself?)? How
> comes it didn't boot between these 4 commits? Does the failure affects
> the host or the guest?

I inadvertently cut out the crash log from the original email, hope this helps:

https://launchpadlibrarian.net/358687166/submission_2018-02-26T14.58.17.996524.html#9-1-log
-- 
bye,
p.
