From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 14 Aug 2014 13:51:43 +0100
Subject: [PATCH] ARM: Use 'model' property to set machine_name from
 Device Tree
In-Reply-To: <1404697991-32191-1-git-send-email-cw00.choi@samsung.com>
References: <1404697991-32191-1-git-send-email-cw00.choi@samsung.com>
Message-ID: <20140814125143.GC9039@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 07, 2014 at 02:53:11AM +0100, Chanwoo Choi wrote:
> This patch use 'model' property from Device Tree to set machine_name.
> The arm64 has already got the machine_name from Device Tree.

FWIW, we removed this entirely from arm64 (see commit d7a49086f2 "arm64:
cpuinfo: print info for all CPUs").

-- 
Catalin
