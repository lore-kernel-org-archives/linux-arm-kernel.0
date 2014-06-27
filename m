From: khilman@linaro.org (Kevin Hilman)
Date: Fri, 27 Jun 2014 07:48:48 -0700
Subject: [PATCH 2/3] ARM: dts: Update the parent for Audss clocks in
 Exynos5420
In-Reply-To: <CAGa+x86COQz+cYtrXWrP-sjFGz-gi2tf6GEvLiKYoQwg1zMivQ@mail.gmail.com>
References: <1402464739-19044-1-git-send-email-tushar.b@samsung.com>
 <1402464739-19044-3-git-send-email-tushar.b@samsung.com>
 <CAD=FV=W5yh58fYTwRZxmZt=BORcZMSRV0oRe12yA74Q5h2S4YQ@mail.gmail.com>
 <7hpphwlgn0.fsf@paris.lan>
 <CAC5m3Bzey-YoPLmjAq4YNPQ13rojtVFWAbnhX6-ZFtYZwEdMWg@mail.gmail.com>
 <7h8uojk61a.fsf@paris.lan> <53ACE724.7090606@gmail.com>
 <CAGa+x86COQz+cYtrXWrP-sjFGz-gi2tf6GEvLiKYoQwg1zMivQ@mail.gmail.com>
Message-ID: <CAGa+x87LHiYGb03=GRcZisK1=TyakW1htd1E2vOQ6ijZKw8syg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 27, 2014 at 7:18 AM, Kevin Hilman <khilman@linaro.org> wrote:
> On Thu, Jun 26, 2014 at 8:38 PM, Tushar Behera <trblinux@gmail.com> wrote:
>
>> Would you please provide me the environment setting of your u-boot?
>> U-boot environment on my board has been over-written, I would like to
>> set it same as yours and try to reproduce the issue at my end. With only
>> 'sound init', I don't seem to hit this issue anymore.
>
> Attached is a full boot log using v3.16-rc2 with my patch adding
> CLK_IGNORE_UNUSED to mau_epll and Doug's aclk66_peric patch.  In the
> boot log, you'll see the output of 'printenv' inside u-boot where the
> environment is dumped.

Oops, I sent you a boot log for the octa board.  Here's the one for
peach-pi with the same kernel (built with upstream exynos_defconfig)

Kevin
-------------- next part --------------
A non-text attachment was scrubbed...
Name: boot-chromebook2.log.gz
Type: application/x-gzip
Size: 8850 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140627/a95b6b32/attachment.bin>
