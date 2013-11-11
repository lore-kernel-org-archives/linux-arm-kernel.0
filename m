From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 11 Nov 2013 14:24:11 -0700
Subject: [RFC DTC PATCH] dtc: add symlink (-L) output to dtbs
In-Reply-To: <1384201760-16785-1-git-send-email-jason@lakedaemon.net>
References: <1384201760-16785-1-git-send-email-jason@lakedaemon.net>
Message-ID: <52814AFB.3070600@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/11/2013 01:29 PM, Jason Cooper wrote:
> Consumers of the Linux kernel's build products are beginning to hardcode
> the filenames of the dtbs generated.  Since the dtb filenames are
> currently the dts filename s/dts/dtb/, this prevents the kernel
> community from renaming dts files as needed.

My take is that the DTB filenames are part of the ABI, and therefore the
DTS filenames are also part of the ABI. Why would we want to rename them?
