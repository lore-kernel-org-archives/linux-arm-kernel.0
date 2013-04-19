From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri, 19 Apr 2013 19:41:52 +0200
Subject: [GIT PULL V3 1/4] mvebu driver changes for v3.10
In-Reply-To: <CAOesGMiRbpfhnVS3DMtK5zkkA4_d4Ktd0Z9s-dg3h4DBNyxYFg@mail.gmail.com>
References: <20130415182824.GN28693@titan.lakedaemon.net>
 <20130416150416.GB28693@titan.lakedaemon.net>
 <20130418053002.GB12816@quad.lixom.net>
 <CAOesGMjD-VAZW-zL-jm65xSJkFLpzbYOdvN6-5pV1OW_vJDCWg@mail.gmail.com>
 <517155FE.30406@free-electrons.com> <51716CD9.4030901@free-electrons.com>
 <20130419172135.GJ27197@titan.lakedaemon.net>
 <CAOesGMiRbpfhnVS3DMtK5zkkA4_d4Ktd0Z9s-dg3h4DBNyxYFg@mail.gmail.com>
Message-ID: <517181E0.7040203@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/19/2013 07:24 PM, Olof Johansson wrote:
> On Fri, Apr 19, 2013 at 10:21 AM, Jason Cooper <jason@lakedaemon.net> wrote:
>>
>> I have dropped:
>>
>>   9ecbe03 pci: infrastructure to add drivers in drivers/pci/host
>>
>> Since Gregory said they didn't need it.
>>
>> thx,
>>
>> Jason.
>>
>> The following changes since commit 8bb9660418e05bb1845ac1a2428444d78e322cc7:
>>
>>   Linux 3.9-rc4 (2013-03-23 16:52:44 -0700)
>>
>> are available in the git repository at:
>>
>>   git://git.infradead.org/users/jcooper/linux.git tags/drivers-3.10-2
>>
>> for you to fetch changes up to a5eddfb24302b9cfb37ce5f0911f090681507fcb:
>>
>>   clk: mvebu: add more PCIe clocks for Armada XP (2013-04-19 17:15:42 +0000)
> 
> Sorry, not pulling this for 3.10.

I don't ask you to pull anything, just to revert this single
commit which have been identified to break the build.

However it would sound very strange to me to drop the dozen of
other commits which are not at all related to this one.


> 
> There will likely not be another linux-next before the merge window
> opens, so there is no time for trial and error.
> 
> Please send a new pull request after -rc1.
> 
> 
> Thanks,
> 
> -Olof
> 


-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
