From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 24 Jan 2013 16:26:28 +0000
Subject: [PATCH v6 00/15] KVM/ARM Implementation
In-Reply-To: <20130116175716.29147.15348.stgit@ubuntu>
References: <20130116175716.29147.15348.stgit@ubuntu>
Message-ID: <20130124162627.GE18233@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Christoffer,

On Wed, Jan 16, 2013 at 05:57:19PM +0000, Christoffer Dall wrote:
> The following series implements KVM support for ARM processors,
> specifically on the Cortex A-15 platform.

I went through the KVM patches (just this series, not the vgic or
timers) and apart from a few minor clean-up issues (which can be done
later as an additional patch) they look fine to me.

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
