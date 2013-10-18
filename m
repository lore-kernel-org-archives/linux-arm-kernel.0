From: wsa@the-dreams.de (Wolfram Sang)
Date: Fri, 18 Oct 2013 08:32:10 +0100
Subject: getting rid of subsys_initcall usage? (was: Re: [PATCH RESEND]
 i2c: designware: use module_platform_driver)
In-Reply-To: <20131008221056.GW8313@atomide.com>
References: <1376987548-12366-1-git-send-email-zhangfei.gao@linaro.org>
 <20130828095706.GH4086@katana>
 <CACRpkdb1p1=3a0PM+r2ZrMN+ECv5BAZFdv2omDK5npaer4ddcw@mail.gmail.com>
 <CAMj5BkhQkwb+T9VepN7UrWNRSgtv=Dw-Sa-gv0orOANo55iqNw@mail.gmail.com>
 <20130830054858.GR7656@atomide.com>
 <CAMj5BkiDExikXi3JcVhO7RN8_82eGYhq3i6oPf5Wbipy=N+iHQ@mail.gmail.com>
 <20130830082712.GT7656@atomide.com> <20131008205304.GA29121@katana>
 <20131008221056.GW8313@atomide.com>
Message-ID: <20131018073210.GA3059@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> Well it should be pretty trivial to update drivers to use deferred
> probing. Maybe some spatch to check for that in driver probes would
> help getting an idea how many might be affected?

That's what I am trying to say. It surely is easy to fix the drivers,
once we know there is something in need of fixing. My question was if
there is common sense to simply risk breaking things and fix them later
(then I'd apply patches switching from subsys_initcall to module_init
right away), or if we can gather ideas how to minimize the impact of
regressions (before applying such patches).

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131018/2440a2f2/attachment.sig>
