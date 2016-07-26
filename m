From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Tue, 26 Jul 2016 17:16:03 +0900
Subject: [PATCH v1.2 3/4] arm64: Add arm64 kexec support
In-Reply-To: <CAB=otbS8Okq+f2SvWkXX1rHO6N+nYTjsF7=Qo9MVU5NSV5Xfsg@mail.gmail.com>
References: <cover.1468970114.git.geoff@infradead.org>
 <9ed513fd44a19b2f49b4da99477cedfff7341bf0.1468970114.git.geoff@infradead.org>
 <1469048065.2977.124.camel@infradead.org>
 <CAB=otbSObtEE7n4LjWWZZ0G=oA1Xd5QUmHnX44+uyUiWP4qXpw@mail.gmail.com>
 <1469479817.2889.4.camel@infradead.org>
 <CAB=otbS8Okq+f2SvWkXX1rHO6N+nYTjsF7=Qo9MVU5NSV5Xfsg@mail.gmail.com>
Message-ID: <20160726081602.GB2363@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 26, 2016 at 04:36:01AM +0300, Ruslan Bilovol wrote:
> Hi Geoff,
> 
> On Mon, Jul 25, 2016 at 11:50 PM, Geoff Levand <geoff@infradead.org> wrote:
> > Hi Ruslan,
> >
> > On Mon, 2016-07-25 at 17:28 +0300, Ruslan Bilovol wrote:
> >> And I use kexec next way:
> >> kexec --type Image -p /Image --ramdisk=/ramdisk.cpio.gz
> >> --dtb=dtb-arm64.dtb --append="root=/dev/ram0 1 maxcpus=1
> >> reset_devices"
> >
> > This patch set only supports re-boot.  '-p' is not supported.
> >
> > I'll look into emiting a message when -p is passed.
> >
> 
> Thanks for explanation.
> 
> By the way, do you know if there is any work ongoing on '-p' option
> support for ARM64? I would be happy to test it on my setup

See my patches (kernel and kexec-tools) that I've just sent out.
It is very kind of you to report your test result.

Thanks,
-Takahiro AKASHI

> Best regards,
> Ruslan
