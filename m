From: florian@openwrt.org (Florian Fainelli)
Date: Sat, 24 Jan 2015 22:22:25 -0800
Subject: [GIT PULL] ARM: BCM5301X: DT changes for v3.20
In-Reply-To: <20150123220111.GE20896@quad.lixom.net>
References: <54BED7D7.80207@hauke-m.de> <20150123220111.GE20896@quad.lixom.net>
Message-ID: <54C48BA1.9080902@openwrt.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



Le 23/01/2015 14:01, Olof Johansson a ?crit :
> On Tue, Jan 20, 2015 at 11:33:59PM +0100, Hauke Mehrtens wrote:
>> Hi Olof, Hi Arnd,
>>
>> This is a pull request with some dt updates for BCM5301X for 3.20.
>>
>> The following changes since commit 97bf6af1f928216fd6c5a66e8a57bfa95a659672:
>>
>>   Linux 3.19-rc1 (2014-12-20 17:08:50 -0800)
>>
>> are available in the git repository at:
>>
>>   https://github.com/hauke/linux.git tags/bcm5301x-dt-2015-01-20
>>
>> for you to fetch changes up to 5b1864b899d2b591402704dd0f6528c8661f1817:
>>
>>   ARM: BCM5301X: Add DT for Buffalo WZR-900DHP (2015-01-20 23:23:25 +0100)
> 
> Hi Hauke,
> 
> I've merged this into next/dt now, comments below.
> 
>>
>> ----------------------------------------------------------------
>> bcm5301x-dt-2015-01-20: ARM: BCM5301X: dts updates for 3.20
>>
>> Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
> 
> No signed-off-by needed in the tag -- the fact that you have signed it is
> enough. We do ask for a few words about what's in the branch though more than
> "dts updates". Something to think about going forward.
> 
> Also:
> 
> We had asked that broadcom platforms go in together through Florian from
> here on out, so we don't have to deal with merge requests from each and
> every one of you since there are several subplatforms. Would that be ok
> with you?

Humm, I had asked you and Arnd a couple times if you would actually
agree in us (bcm5301x, cygnus, brcmstb and others) doing separate pull
requests, the rationale being that:

- the previous mach-bcm maintainers had been holding some of our
development because of their lack of responsiveness, so we did not want
to end-up creating the same (potential) situation here with centralized
pull requests

- there is little to no code sharing happening within mach-bcm, so you
would typically only have to merge the Makefile and Kconfig portions

That said, I still have no problems sending grouped pull requests if you
prefer this model (that is sending all broadcom related pull requests
through one maintainer).

Thanks!
--
Florian
