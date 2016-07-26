From: ruslan.bilovol@gmail.com (Ruslan Bilovol)
Date: Tue, 26 Jul 2016 04:36:01 +0300
Subject: [PATCH v1.2 3/4] arm64: Add arm64 kexec support
In-Reply-To: <1469479817.2889.4.camel@infradead.org>
References: <cover.1468970114.git.geoff@infradead.org>
 <9ed513fd44a19b2f49b4da99477cedfff7341bf0.1468970114.git.geoff@infradead.org>
 <1469048065.2977.124.camel@infradead.org>
 <CAB=otbSObtEE7n4LjWWZZ0G=oA1Xd5QUmHnX44+uyUiWP4qXpw@mail.gmail.com>
 <1469479817.2889.4.camel@infradead.org>
Message-ID: <CAB=otbS8Okq+f2SvWkXX1rHO6N+nYTjsF7=Qo9MVU5NSV5Xfsg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Geoff,

On Mon, Jul 25, 2016 at 11:50 PM, Geoff Levand <geoff@infradead.org> wrote:
> Hi Ruslan,
>
> On Mon, 2016-07-25 at 17:28 +0300, Ruslan Bilovol wrote:
>> And I use kexec next way:
>> kexec --type Image -p /Image --ramdisk=/ramdisk.cpio.gz
>> --dtb=dtb-arm64.dtb --append="root=/dev/ram0 1 maxcpus=1
>> reset_devices"
>
> This patch set only supports re-boot.  '-p' is not supported.
>
> I'll look into emiting a message when -p is passed.
>

Thanks for explanation.

By the way, do you know if there is any work ongoing on '-p' option
support for ARM64? I would be happy to test it on my setup

Best regards,
Ruslan
