From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 05 May 2015 12:55:52 +0200
Subject: [Discussion] how to implement external power down for ARM
In-Reply-To: <CAMJs5B9V_tWxut6LLWDdpN1m9NsaC_JGfR_U_SHN=OOhdHe_Yw@mail.gmail.com>
References: <55417F5A.4040300@linaro.org> <2490159.r1U8jHTvO3@wuerfel>
 <CAMJs5B9V_tWxut6LLWDdpN1m9NsaC_JGfR_U_SHN=OOhdHe_Yw@mail.gmail.com>
Message-ID: <9143918.xCQ8d3X4XD@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 05 May 2015 12:51:57 Christoffer Dall wrote:
> On Tue, May 5, 2015 at 11:53 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> > On Tuesday 05 May 2015 12:27:54 Joel Stanley wrote:
> >
> Do ARM distributions (Fedora, Ubuntu, Debian, ...) support the
> necessary userspace handling so that things work with the input
> subsystem?

I think the latest releases all use systemd, so it should work in theory,
but I have not tried it, and I don't know if they have something else
on older versions.

	Arnd
