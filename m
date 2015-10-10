From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Sat, 10 Oct 2015 17:25:04 +0200
Subject: [PATCH] arm/arm64: KVM : Enable vhost device selection under KVM
 config menu
In-Reply-To: <1444403323-8333-1-git-send-email-wei@redhat.com>
References: <1444403323-8333-1-git-send-email-wei@redhat.com>
Message-ID: <20151010152504.GF29128@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 09, 2015 at 10:08:43AM -0500, Wei Huang wrote:
> vhost drivers provide guest VMs with better I/O performance and lower
> CPU utilization. This patch allows users to select vhost devices under
> KVM configuration menu on ARM. This makes vhost support on arm/arm64
> on a par with other architectures (e.g. x86, ppc).
> 
> Signed-off-by: Wei Huang <wei@redhat.com>

Thanks, applied to queue.

-Christoffer
