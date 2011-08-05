From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 5 Aug 2011 11:06:47 +0100
Subject: [PATCH] fix cpuidle_xxx functions name mismatch
In-Reply-To: <1312533111-22231-1-git-send-email-alex.bluesman.smirnov@gmail.com>
References: <1312533111-22231-1-git-send-email-alex.bluesman.smirnov@gmail.com>
Message-ID: <20110805100647.GD20575@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 05, 2011 at 12:31:51PM +0400, Alexander Smirnov wrote:
> In header there is defined 'cpuidle_idle_call' function,
> in arm/kernel/process.c file it's used 'cpuidle_call_idle'
> 
> Signed-off-by: Alexander Smirnov <alex.bluesman.smirnov@gmail.com>

See cbc158d (cpuidle: Consistent spelling of cpuidle_idle_call())
