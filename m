From: rostedt@goodmis.org (Steven Rostedt)
Date: Tue, 6 Dec 2016 21:45:23 -0500
Subject: [PATCH 7/7] arm: Add livepatch necessary arch selects into Kconfig
In-Reply-To: <1481043967-15602-8-git-send-email-abelvesa@linux.com>
References: <1481043967-15602-1-git-send-email-abelvesa@linux.com>
 <1481043967-15602-8-git-send-email-abelvesa@linux.com>
Message-ID: <20161206214523.5166e700@grimm.local.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue,  6 Dec 2016 17:06:07 +0000
Abel Vesa <abelvesa@linux.com> wrote:

> This adds HAVE_LIVEPATCH, MODULES_USE_ELF_RELA and HAVE_LIVEPATCH
> to arm Kconfig.
> 
> Signed-off-by: Abel Vesa <abelvesa@linux.com>

Patch 5, 6 and 7 really ought to be one patch.

-- Steve
