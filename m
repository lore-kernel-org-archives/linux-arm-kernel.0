From: will.deacon@arm.com (Will Deacon)
Date: Thu, 19 Sep 2013 10:36:28 +0100
Subject: 3.12-rc1: no longer compiles for Nokia n900 (omap based)
In-Reply-To: <20130919093002.GA23806@amd.pavel.ucw.cz>
References: <20130919093002.GA23806@amd.pavel.ucw.cz>
Message-ID: <20130919093627.GB24866@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 19, 2013 at 10:30:02AM +0100, Pavel Machek wrote:
> Hi!
> 
> I get:
> 
>   CC      arch/arm/kernel/machine_kexec.o
> /tmp/ccCFXeXG.s: Assembler messages:
> /tmp/ccCFXeXG.s:217: Error: garbage following instruction -- `dsb
> nshst'
> /tmp/ccCFXeXG.s:225: Error: garbage following instruction -- `dsb nsh'
> make[1]: *** [arch/arm/kernel/suspend.o] Error 1
> make[1]: *** Waiting for unfinished jobs....
> 
> pavel at amd:/data/l/linux-n900$ arm-linux-gnueabi-gcc --version
> arm-linux-gnueabi-gcc (Debian 4.3.5-4) 4.3.5
> 
> Minimum required gcc is 3.2, so I'm safe.

Please check your binutils. >= 2.22 has been reported to work.

Will1
