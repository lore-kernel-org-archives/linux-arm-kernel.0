From: andy.gross@linaro.org (Andy Gross)
Date: Fri, 23 Jun 2017 13:08:16 -0500
Subject: [PATCH] ARM: qcom_defconfig: enable RPMSG_QCOM_SMD
In-Reply-To: <CAK8P3a1ChrTPYC37sZhkF2edfBGOR4m5eFe8=4-y=R-FaVFdMQ@mail.gmail.com>
References: <20170615061521.21292-1-bshah@kde.org>
 <20170621050335.GI17640@tuxbook>
 <CAK8P3a1ChrTPYC37sZhkF2edfBGOR4m5eFe8=4-y=R-FaVFdMQ@mail.gmail.com>
Message-ID: <20170623180816.GC5203@hector.attlocal.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 23, 2017 at 01:49:13PM +0200, Arnd Bergmann wrote:
> On Wed, Jun 21, 2017 at 7:03 AM, Bjorn Andersson
> <bjorn.andersson@linaro.org> wrote:
> > + arm at kernel.org
> >
> > On Wed 14 Jun 23:15 PDT 2017, Bhushan Shah wrote:
> >
> >> As of commit 5052de8deff56, QCOM_SMD_RPM and various other config
> >> options enabled in the qcom_defconfig depends on the RPMSG. If
> >> QCOM_SMD_RPM config option is not selected it disables the
> >> REGULATOR_QCOM_SMD_RPM and other essential config options.
> >>
> >> Signed-off-by: Bhushan Shah <bshah@kde.org>
> >
> > Acked-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> 
> I see that Andy Gross was not on Cc, he would be the right person to
> pick up patches like this one.
> 
> Andy, do you want to pick that up through the qcom tree, or should
> we apply it directly on arm-soc?

I'll send another pull


Expect to see it today/tomorrow.

Thanks!

andy
