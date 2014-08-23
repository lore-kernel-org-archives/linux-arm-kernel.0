From: festevam@gmail.com (Fabio Estevam)
Date: Sat, 23 Aug 2014 12:02:05 -0300
Subject: [PATCH 6/6] ARM: dts: hummingboard: gpio-ir on gpio 3,5
In-Reply-To: <20140823143305.GQ30401@n2100.arm.linux.org.uk>
References: <20140823091058.GO30401@n2100.arm.linux.org.uk>
 <E1XL7MR-0002yX-6N@rmk-PC.arm.linux.org.uk>
 <CAOMZO5C=xyYLLBX1PDsJQ9NwzXZxCWTvPMTUWzYcoohOOvA_qA@mail.gmail.com>
 <20140823133649.GP30401@n2100.arm.linux.org.uk>
 <CAOMZO5DrtrEJxmCZSO6RVZom8kzZhu2dikntRwYZeq5j_QZ9sw@mail.gmail.com>
 <20140823143305.GQ30401@n2100.arm.linux.org.uk>
Message-ID: <CAOMZO5DgPLHwDsRPkssRDT5tKyfOo=Udg6vD5VPUQ43wsV346w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Aug 23, 2014 at 11:33 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:

> Most of the pins not associated with booting the kernel are left
> unconfigured by the boot loader - that's because uboot SPL has very
> little space for such things.
>
> Rabeeh has just told me that 0x1b0b1 would be a better value for it.
> I'll add an additional patch to the series for that, rather than
> modifying Rabeeh's original patch.

Sounds good, thanks.
