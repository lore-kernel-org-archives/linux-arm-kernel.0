From: agraf@suse.de (Alexander Graf)
Date: Tue, 17 Dec 2013 21:39:23 +0100
Subject: [PATCH 2/2] kvmtool/arm: Add option to override Generic Timer
 frequency
In-Reply-To: <1387305074-29421-3-git-send-email-robin.murphy@arm.com>
References: <1387305074-29421-1-git-send-email-robin.murphy@arm.com>
 <1387305074-29421-3-git-send-email-robin.murphy@arm.com>
Message-ID: <308D5B7E-5BDA-4984-9448-EAD8B5D699CF@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 17.12.2013, at 19:31, Robin Murphy <robin.murphy@arm.com> wrote:

> Some platforms have secure firmware which does not correctly set the
> CNTFRQ register on boot, preventing the use of the Generic Timer.
> This patch allows mirroring the necessary host workaround by specifying
> the clock-frequency property in the guest DT.
> 
> This should only be considered a means of KVM bring-up on such systems,
> such that vendors may be convinced to properly implement their firmware
> to support the virtualisation capabilities of their hardware.
> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> Acked-by: Will Deacon <will.deacon@arm.com>

How does it encourage a vendor to properly implement their firmware if there's a workaround?


Alex
