From: santosh.shilimkar@oracle.com (santosh.shilimkar at oracle.com)
Date: Sun, 22 Oct 2017 20:23:19 -0700
Subject: linux-next: build failure after merge of the keystone tree
In-Reply-To: <20171010071924.ddxkylkwq44qh47q@sirena.co.uk>
References: <20171010071924.ddxkylkwq44qh47q@sirena.co.uk>
Message-ID: <3ed1f18a-204c-961a-9d81-b36e00d4aaf5@oracle.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/10/17 12:19 AM, Mark Brown wrote:
> Hi Santosh,
> 
> After merging the keystone tree, today's linux-next build
> (multi_v7_defconfig) failed like this:
> 
>    DTC     arch/arm/boot/dts/keystone-k2g-evm.dtb
> Error: /home/broonie/tmpfs/next/arch/arm/boot/dts/keystone-k2g-evm.dts:150.1-15 syntax error
> FATAL ERROR: Unable to parse input tree
> scripts/Makefile.lib:316: recipe for target 'arch/arm/boot/dts/keystone-k2g-evm.dtb' failed
> make[2]: *** [arch/arm/boot/dts/keystone-k2g-evm.dtb] Error 1
> 
> Caused by commit
> 
>     a6f244505915f ("ARM: dts: keystone-k2g-evm: Add I2C EEPROM DT entry")
> 
> I've used the keystone tree from yesterday.
> 
I fixed this next day but forgot to reply to you Mark.

Regards,
Santosh
