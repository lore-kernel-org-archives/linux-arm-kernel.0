From: santosh.shilimkar@oracle.com (santosh.shilimkar at oracle.com)
Date: Thu, 13 Aug 2015 10:21:31 -0700
Subject: [GIT PULL] ARM: Couple of Keystone MDIO DTS fixes for 4.2-rc6+
In-Reply-To: <20150813102434.GV30160@localhost>
References: <1439177200-32434-1-git-send-email-ssantosh@kernel.org>
 <20150813102434.GV30160@localhost>
Message-ID: <55CCD21B.5030309@oracle.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 8/13/15 3:24 AM, Olof Johansson wrote:
> On Sun, Aug 09, 2015 at 08:26:40PM -0700, Santosh Shilimkar wrote:
>> ARM-SoC folks,
>>
>> Please pull below couple of late fixes for 4.2-rc6+. I know its late
>> with rc6 already out but if possible please consider.
>>
>> The following changes since commit f7644cbfcdf03528f0f450f3940c4985b2291f49:
>>
>>    Linux 4.2-rc6 (2015-08-09 15:54:30 -0400)
>>
>> are available in the git repository at:
>>
>>    git://git.kernel.org/pub/scm/linux/kernel/git/ssantosh/linux-keystone.git tags/keystone-dts-late-fixes
>>
>> for you to fetch changes up to 6a024079862443b3ec9455931e9219cd5912656d:
>>
>>    ARM: dts: keystone: Fix the mdio bindings by moving it to soc specific file (2015-08-09 20:06:27 -0700)
>
> Hi,
>
> Our fixes branch is still at -rc2. Would you mind respinning with an older
> base unless there are conflicts?
>
Just created v2. I tried merging with arm-soc/fixes and it merge
cleanly. Please pull below.

 
git://git.kernel.org/pub/scm/linux/kernel/git/ssantosh/linux-keystone.git tags/keystone-dts-late-fixes-v2

Thanks and regards,
Santosh
