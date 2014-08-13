From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 13 Aug 2014 10:59:45 +0100
Subject: [PATCH v9 11/12] arm64: Add pgprot_device() interface for device
 mappings.
In-Reply-To: <1407860725-25202-12-git-send-email-Liviu.Dudau@arm.com>
References: <1407860725-25202-1-git-send-email-Liviu.Dudau@arm.com>
 <1407860725-25202-12-git-send-email-Liviu.Dudau@arm.com>
Message-ID: <20140813095944.GB18495@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 12, 2014 at 05:25:24PM +0100, Liviu Dudau wrote:
> Add pgprot_device(). It will be aliased to pgprot_noncached for
> architectures that do not support special attributes for device
> mapping. Used by arm64 to define new attributes for devices.
> 
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Signed-off-by: Liviu Dudau <Liviu.Dudau@arm.com>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
