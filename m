From: mika.westerberg@iki.fi (Mika Westerberg)
Date: Thu, 21 Oct 2010 19:44:33 +0300
Subject: BUG: spinlock recursion on CPU#0
In-Reply-To: <201010211612.46685.alexander.stein@systec-electronic.com>
References: <201010211612.46685.alexander.stein@systec-electronic.com>
Message-ID: <20101021164433.GH4772@gw.healthdatacare.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 21, 2010 at 04:12:28PM +0200, Alexander Stein wrote:

[...]

> After sme searching i found this patch:
> http://permalink.gmane.org/gmane.linux.ports.arm.kernel/79676
> I didn't try any of the demos in this patch, but I applied the changes and the 
> BUG didn't occur anymore.
> Now I'm wondering what's the status of this patch and is this the right 
> approach to handle this problem.

I didn't receive any comments on the patch so it ended up only in
my local tree.

The problem seems to reproduce with the latest mainline also so I
guess it is time to resend the patch. Will do that in a minute.

Regards,
MW
