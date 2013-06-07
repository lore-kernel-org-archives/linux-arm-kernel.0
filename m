From: olof@lixom.net (Olof Johansson)
Date: Fri, 7 Jun 2013 16:40:25 -0700
Subject: [GIT PULL] ARM dts cpus/cpu nodes updates
In-Reply-To: <20130523104858.GA2986@e102568-lin.cambridge.arm.com>
References: <20130523104858.GA2986@e102568-lin.cambridge.arm.com>
Message-ID: <20130607234025.GA24278@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 23, 2013 at 11:48:58AM +0100, Lorenzo Pieralisi wrote:
> Hi Arnd, Olof,
> 
> please pull dts cpus/cpu node updates for all non-compliant ARM
> SoC/boards. Please notice I could not update all dts files since some of
> them are missing the cpus node altogether and I simply can not know
> the CPUs configuration for them, it is up to maintainers to patch the
> respective dts to comply with the latest specification.
> 
> I have just sent a different pull request for related documentation:
> 
> http://lists.infradead.org/pipermail/linux-arm-kernel/2013-May/170234.html
> 
> dts updates comply with those Documentation updates.
> 
> Thank you very much indeed,
> Lorenzo
> 
> The following changes since commit c7788792a5e7b0d5d7f96d0766b4cb6112d47d75:
> 
>   Linux 3.10-rc2 (2013-05-20 14:37:38 -0700)
> 
> are available in the git repository at:
> 
>   git://linux-arm.org/linux-2.6-lp.git dts-cpus-updates

Thanks, pulled into next/dt.


-Olof
