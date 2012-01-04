From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 4 Jan 2012 21:15:36 +0000
Subject: updating machine registry for 2843/pcaal1
In-Reply-To: <4F032A10.9030203@phytec.de>
References: <4F032A10.9030203@phytec.de>
Message-ID: <20120104211536.GE11810@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 03, 2012 at 05:17:20PM +0100, J?rgen Kilb wrote:
> Hi Russell,
>
> I've tried to fix the machine name of our product in the machine  
> registry for machine number 2843.
> The correct name is pcaal1. As you can see the machine name and the type  
> macro are correct now.
>
> Could you please update the Kconfig macro and the Type Identifier ?
>
> is:
> machine_is_pcaal1()
> CONFIG_MACH_PCA102
> MACH_TYPE_PCA102
>
> should be:
> machine_is_pcaal1()
> CONFIG_MACH_PCAAL1
> MACH_TYPE_PCAAL1

Updated.

Please confirm it's correct.  Thanks.
