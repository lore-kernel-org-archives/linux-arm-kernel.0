From: nareshgbhat@gmail.com (Naresh Bhat)
Date: Tue, 20 Nov 2012 22:44:07 +0530
Subject: KEXEC on ARM cortex-a15
In-Reply-To: <20121120160219.GF26475@mudshark.cambridge.arm.com>
References: <CAJXQGfKpFfUwMeLGFAuTgQn5Yd2D9O271JM1VJ87Nio80tbwXw@mail.gmail.com>
 <20121119144417.GH3290@n2100.arm.linux.org.uk>
 <20121119151327.GG3205@mudshark.cambridge.arm.com>
 <CAJXQGf+BQ18GhR3emhK-ejTivqx_o=gtaO3-FjTiE3BMGydgsw@mail.gmail.com>
 <CAJXQGf+wfXGZ=PWN585dJDMX1nH+sRexf6UZujyjKM6rJeDiXQ@mail.gmail.com>
 <20121120160219.GF26475@mudshark.cambridge.arm.com>
Message-ID: <CAJXQGfKneStLD5iGhybANWcokVvoL4bLHQi1U=rsBXcDgvj21w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Will Deacon,

> Your platform probably doesn't park the secondary CPUs correctly. Try
> booting the kexec host kernel with 'nosmp' on the command line.

Do you mean I need to boot the

STEP1:

Daughterboard Site 1: V2P-CA15_A7 Cortex A15

I should boot with "nosmp" in command line

STEP2:
run the kexec on the above booted target ?

--Thanks and Regards
"For things to change, we must change"
-Naresh Bhat
