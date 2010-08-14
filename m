From: marek.vasut@gmail.com (Marek Vasut)
Date: Sat, 14 Aug 2010 08:53:03 +0200
Subject: [Openpxa-users] Colibri PXA320 Power management question
In-Reply-To: <AANLkTik_6ziPZwV9EuZwE4SMtJoc10JrBZZ_-mmsuy5a@mail.gmail.com>
References: <AANLkTik_6ziPZwV9EuZwE4SMtJoc10JrBZZ_-mmsuy5a@mail.gmail.com>
Message-ID: <201008140853.03174.marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dne ?t 12. srpna 2010 12:02:17 Yuri Ludkevich napsal(a):
> Hi there :)
> 
> I have a question about power management of Colibri PXA320 module:
> I found that bits PVE and FVE in PVCR register are disabled,
> so at frequency change voltage will not change.
> 
> If I turn on PVE and FVE with pxaregs tool - voltage changes just fine.
> Where are suitable place in the kernel for PVCR initialization?

I believe kernel should handle all that. Eric CCed.
