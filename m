From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Tue, 10 Jul 2012 14:18:45 +0200
Subject: [PATCH v9] arm: Add basic support for new Marvell Armada 370
 and Armada XP SoC
In-Reply-To: <201207101203.30984.arnd@arndb.de>
References: <1341588221-3822-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <20120710111655.071a4ab1@skate> <201207101203.30984.arnd@arndb.de>
Message-ID: <4FFC1DA5.6050805@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/10/2012 02:03 PM, Arnd Bergmann wrote:
> On Tuesday 10 July 2012, Thomas Petazzoni wrote:
>> Le Fri,  6 Jul 2012 17:23:32 +0200,
>> Thomas Petazzoni <thomas.petazzoni@free-electrons.com> a ?crit :
>>
>>> You'll find in this patch set the nineth version of the initial
>>> support for a new family of ARMv7-compatible Marvell SoCs.
>>
>> This v9 version has received Acked-by from Andrew Lunn on the
>> different patches, we have solved the maintainership question of the
>> new mach-mvebu directory, and so far there hasn't been additional
>> comments on this v9.
>>
>> Is there anything we can do to help in getting this patch set merged?
> 
> Usually I'm waiting for git pull requests, which fits the arm-soc
> workflow best, but it's also ok to ask for patches to be included,
> especially if you do not have a public git tree.
> 
> Should I apply the patches to a new branch in arm-soc or do you
> send a pull request?
> 

We have a public git tree available at:

https://github.com/Marvell-Semi/EBU_mainline_public.git

this last patch set is directly from mvebu_for-next-V9 branch.

Do you need a formal request?

> 	Arnd
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 


-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
