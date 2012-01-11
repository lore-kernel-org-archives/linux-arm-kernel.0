From: timur@freescale.com (Timur Tabi)
Date: Wed, 11 Jan 2012 14:32:38 -0600
Subject: [PATCH] ARM: vexpress: initial device tree support
In-Reply-To: <74CDBE0F657A3D45AFBB94109FB122FF177EE3A770@HQMAIL01.nvidia.com>
References: <1316596786-2539-1-git-send-email-dave.martin@linaro.org>
 <CAOZdJXXPJEaFO-ymvb_TsTJ6W2T7_aWXA=9RZprVmKBOn9cu8A@mail.gmail.com>
 <4F0B897A.20502@firmworks.com>
 <20120110122252.GA7180@jl-vm1.vm.bytemark.co.uk>
 <4F0CB485.9010106@freescale.com> <4F0CBD46.2010909@firmworks.com>
 <4F0CD7BC.7080409@freescale.com> <4F0D2F90.8020801@firmworks.com>
 <74CDBE0F657A3D45AFBB94109FB122FF177EE3A770@HQMAIL01.nvidia.com>
Message-ID: <4F0DF1E6.40602@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Stephen Warren wrote:
> Well, the EDID needs to be read on every hotplug event, so it's certainly
> not a one-time thing.

What is the hotplug event that triggers an EDID read?  

-- 
Timur Tabi
Linux kernel developer at Freescale
