From: tixy@linaro.org (Jon Medhurst (Tixy))
Date: Wed, 29 Jul 2015 10:20:38 +0100
Subject: [PATCH 0/2] arm64: support initrd outside of mapped RAM
In-Reply-To: <1438093961-15536-1-git-send-email-msalter@redhat.com>
References: <1438093961-15536-1-git-send-email-msalter@redhat.com>
Message-ID: <1438161638.3129.4.camel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2015-07-28 at 10:32 -0400, Mark Salter wrote:
> When booting an arm64 kernel w/initrd using UEFI/grub, use of mem= will likely
> cut off part or all of the initrd. This leaves it outside the kernel linear
> map which leads to failure when unpacking.

Have we got a similar issue for the device-tree blob?

-- 
Tixy
