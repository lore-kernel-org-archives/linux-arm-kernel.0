From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Fri, 21 Jun 2013 11:49:07 -0700
Subject: [PATCH v2 0/3] A handful of KVM/ARM fixes
In-Reply-To: <1371816528-25078-1-git-send-email-marc.zyngier@arm.com>
References: <1371816528-25078-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <20130621184907.GC2816@lvm>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 21, 2013 at 01:08:45PM +0100, Marc Zyngier wrote:
> This is a small patch series that I accumulated while tracking what
> turned out to be an unrelated issue.
> 
> The first patch has already been posted a while ago and included here
> for completeness. The others are fairly simple missing barriers/clear
> exclusives that are actually required.
> 
> This has been tested on TC2, and is also available in my tree:
> git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git kvm-arm/fixes-3.10-rc6
> 
Applied with the minor fixes addressed on the individual patch mails.

Thanks,
-Christoffer
