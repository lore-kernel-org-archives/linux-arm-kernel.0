From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 12 Feb 2013 11:03:28 +0000
Subject: [PATCH 07/16] ARM64 idle: delete pm_idle
In-Reply-To: <c09e2c0f2928cfe6173bcafe0d906bf87287d5c2.1360475150.git.len.brown@intel.com>
References: <2b219d07e0f287c2c713f5465fc8646158fa986e.1360475150.git.len.brown@intel.com>
 <c09e2c0f2928cfe6173bcafe0d906bf87287d5c2.1360475150.git.len.brown@intel.com>
Message-ID: <20130212110328.GB14899@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Feb 10, 2013 at 05:58:14AM +0000, Len Brown wrote:
> From: Len Brown <len.brown@intel.com>
> 
> pm_idle() on arm64 was a synonym for default_idle(),
> so remove it and invoke default_idle() directly.
> 
> Signed-off-by: Len Brown <len.brown@intel.com>
> Cc: linux-arm-kernel at lists.infradead.org

For arm64:

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
