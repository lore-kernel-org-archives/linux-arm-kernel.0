From: khilman@ti.com (Kevin Hilman)
Date: Thu, 08 Mar 2012 10:09:32 -0800
Subject: [GIT PULL] ARM: OMAP2+: PM: core support for SMPS regulators for
 v3.4
In-Reply-To: <20120308021843.GQ12083@atomide.com> (Tony Lindgren's message of
 "Wed, 7 Mar 2012 18:18:43 -0800")
References: <877gywjhht.fsf@ti.com> <20120308021843.GQ12083@atomide.com>
Message-ID: <87399jc6cj.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tony Lindgren <tony@atomide.com> writes:

> * Kevin Hilman <khilman@ti.com> [120307 11:42]:
>> Tony,
>> 
>> Please pull the following support for using regulators to control the
>> on-chip VC/VP managed voltage domains.
>> 
>> The regulator driver support for this is already queued in the regulator
>> tree, and this is the supporting core work.
>> 
>> This combined with the CPUfreq changes to use the regulator framework
>> will finally result in MPU DVFS working in mainline.
>
> Nice.. However this one might be missing some header changes?

Oh, that's because it depends on the regulator core changes that are in
Mark's regulator tree.  You need the for-next branch of :

git://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git 

For this to compile correctly.

Sorry, I should've been more clear above about the build dependency.

Kevin
