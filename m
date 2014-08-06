From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 6 Aug 2014 13:01:28 -0300
Subject: [Regression] FEC: Panic on suspend in 3.16
In-Reply-To: <20140806154711.GQ30282@n2100.arm.linux.org.uk>
References: <53E24147.4050304@parkeon.com> <53E24525.2020809@mentor.com>
 <53E24A99.2020604@denx.de>
 <20140806154711.GQ30282@n2100.arm.linux.org.uk>
Message-ID: <CAOMZO5ASEsy0NUus3w13zkhq2FsF9x6X5Ce28dXqZFAbQ0E6uA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 6, 2014 at 12:47 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:

> As Nathan says, the problem is caused by a71e3c37960c and the fix which
> will soon be merged into mainline and stable trees will be a revert of
> that commit.

Yes, Dave has already queued the revert for stable:
https://git.kernel.org/cgit/linux/kernel/git/davem/net.git/commit/?id=ce7991e8198b80eb6b4441b6f6114bea4a665d66
