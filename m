From: mturquette@linaro.org (Mike Turquette)
Date: Fri, 25 Jul 2014 17:42:12 -0700
Subject: [PATCH v2 0/6] Migrate PXA27x platforms to clock framework
In-Reply-To: <87k376vadk.fsf@free.fr>
References: <1405353263-13424-1-git-send-email-robert.jarzmik@free.fr>
 <87k376vadk.fsf@free.fr>
Message-ID: <20140726004212.4791.52407@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Robert Jarzmik (2014-07-21 11:23:51)
> Robert Jarzmik <robert.jarzmik@free.fr> writes:
> 
> > This is the second opus of this serie.
> 
> Ping ?

Hi Robert,

Overall the series looks good to me. The only problem I see is that
somewhere in the use of the PARENTS() macro there is a section mismatch
introduced. I spent about 5 minutes looking at it and gave up. This
problem introduces 26 section mismatch warnings building
colibri_pxa270_defconfig.

Once those are fixed up then I will be happy to take this series. Do you
want me to take all six patches through the clk tree, including the
arm/arm stuff?

Regards,
Mike

> 
> --
> Robert
