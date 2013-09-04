From: khilman@linaro.org (Kevin Hilman)
Date: Wed, 4 Sep 2013 08:01:32 -0700
Subject: [PATCHv3 0/9] ARM: OMAP2+: AM33XX: Add suspend-resume support
In-Reply-To: <52261B34.60206@ti.com>
References: <1375811376-49985-1-git-send-email-d-gerlach@ti.com>
 <5211E3F6.6090108@ti.com> <52125A39.3010008@ti.com>
 <87vc2qyjao.fsf@linaro.org> <521FBD6B.3020208@ti.com>
 <87mwo0rvf8.fsf@linaro.org>
 <CA+Bv8Xamd7e24nswG4QhLDNhHXs92EfXcfu8E2uL=XLhsL70Hw@mail.gmail.com>
 <CAGa+x84okZ_j71=oOnK5c43T9L3gmsGcQjWSxZSchfzheA_2HQ@mail.gmail.com>
 <52261B34.60206@ti.com>
Message-ID: <CAGa+x85D2tnX_9QDNb6s1LQCpAz_kGUiOK82C7fPLVTmiZMEFg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Dave,

> Thanks for taking the time to try this out, it does seem there are a few
> kinks with BeagleBone Black but we'll get those worked out.

I also just noticed that wake from RTC isn't working, but wake from
serial console does.  Does RTC wake work for you?  (I use rtcwake -m
mem -s4)

Kevin
