From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 10 Nov 2018 09:57:27 +0100
Subject: [PATCH v2 2/9] arm64: defconfig: Drop ARM_BIG_LITTLE_CPUFREQ
In-Reply-To: <20181108093617.GB8433@e107155-lin>
References: <898e79a6-092c-d013-d2bb-f6260e761379@free.fr>
 <03f41ca8-68c6-f075-cb1e-c7f630a3b128@free.fr>
 <20181108093617.GB8433@e107155-lin>
Message-ID: <CAK8P3a1129B-u60sjHCvLuE8i6OCJRDSe-JFy3S-JJWFGbHCPQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 8, 2018 at 10:36 AM Sudeep Holla <sudeep.holla@arm.com> wrote:
>
> On Wed, Nov 07, 2018 at 11:39:42PM +0100, Marc Gonzalez wrote:
> > Commit a7314405d83c ("drop ARM_BIG_LITTLE_CPUFREQ support for ARM64")
> > dropped ARM_BIG_LITTLE_CPUFREQ support for ARM64.
> >
>
> Looks good,
>
> Acked-by: Sudeep Holla <sudeep.holla@arm.com>
>
> But I left it intentionally to avoid churn assuming it will go away when
> ARM SoC team runs savedefconfig and sync the defconfig.

I would never do that, instead I want patches like the one that Marc sent
in order to make sure we don't accidentally drop anything that is still
required, e.g. when an option got renamed or gained a dependency.

       Arnd
