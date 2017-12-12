From: mylene.josserand@free-electrons.com (Mylene JOSSERAND)
Date: Tue, 12 Dec 2017 11:01:41 +0100
Subject: [PATCH 0/4] Sunxi: Add SMP support on A83T
In-Reply-To: <20171212104025.0bba3685@dell-desktop.home>
References: <20171211075001.6100-1-mylene.josserand@free-electrons.com>
 <20171211193534.GA3967@Red>
 <20171212104025.0bba3685@dell-desktop.home>
Message-ID: <20171212110141.19892b79@dell-desktop.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le Tue, 12 Dec 2017 10:40:25 +0100,
Mylene JOSSERAND <mylene.josserand@free-electrons.com> a ?crit :

[...]

> I have done further tests.
> 
> I booted a previous kernel that I know it was working fine (kernel
> v4.13) then, I booted the kernel with this series and it worked just
> fine.
> 
> Only after a power cycle, I am able to reproduce the error, otherwise,
> it is working well. See the boot log of this two tests:
> http://code.bulix.org/7kr0e0-239697?raw

I wrote this mail too fast, I am wrong, the error I had/copied is not
the same error than Corentin is having (and I have 8 CPUS up).

-- 
Myl?ne Josserand, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
