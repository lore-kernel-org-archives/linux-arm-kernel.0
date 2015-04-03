From: ivo.g.dimitrov.75@gmail.com (Ivaylo Dimitrov)
Date: Sat, 04 Apr 2015 01:08:16 +0300
Subject: ARM errata 430973 on multi platform kernels
In-Reply-To: <20150403163553.GA16247@earth>
References: <1425236828-28349-1-git-send-email-jarkko.nikula@bitmer.com>
 <55197A12.1050009@bitmer.com> <20150330164237.GJ10805@atomide.com>
 <55198BA4.5010207@bitmer.com> <20150330175051.GK10805@atomide.com>
 <20150331123233.GA15103@earth> <20150401194734.GT10805@atomide.com>
 <20150403163553.GA16247@earth>
Message-ID: <551F0F50.1030701@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi

On  3.04.2015 19:35, Sebastian Reichel wrote:
>
> Maybe an option would be to provide two cpu_v7_switch_mm
> implementations (one with the errata and one without). Then
> the system can start with the simple implementation. Once
> the boot as progressed far enough to know, that the hardware
> is affected by the errata, it could switch to the implementation
> with the flushing.

Or rather the opposite, as if the kernel itself is thumb-compiled, it 
most probably will have no chance to progress enough to switch to the 
correct implementation before hanging.
>
> -- Sebastian
>

Ivo
