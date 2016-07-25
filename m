From: geoff@infradead.org (Geoff Levand)
Date: Mon, 25 Jul 2016 13:50:17 -0700
Subject: [PATCH v1.2 3/4] arm64: Add arm64 kexec support
In-Reply-To: <CAB=otbSObtEE7n4LjWWZZ0G=oA1Xd5QUmHnX44+uyUiWP4qXpw@mail.gmail.com>
References: <cover.1468970114.git.geoff@infradead.org>
 <9ed513fd44a19b2f49b4da99477cedfff7341bf0.1468970114.git.geoff@infradead.org>
 <1469048065.2977.124.camel@infradead.org>
 <CAB=otbSObtEE7n4LjWWZZ0G=oA1Xd5QUmHnX44+uyUiWP4qXpw@mail.gmail.com>
Message-ID: <1469479817.2889.4.camel@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ruslan,

On Mon, 2016-07-25 at 17:28 +0300, Ruslan Bilovol wrote:
> And I use kexec next way:
> kexec --type Image -p /Image --ramdisk=/ramdisk.cpio.gz
> --dtb=dtb-arm64.dtb --append="root=/dev/ram0 1 maxcpus=1
> reset_devices"

This patch set only supports re-boot.  '-p' is not supported.

I'll look into emiting a message when -p is passed.

-Geoff
