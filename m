From: kaloz@openwrt.org (Imre Kaloz)
Date: Thu, 23 Feb 2017 13:59:18 +0100
Subject: [PATCH] ARM: dts: BCM5301X: Add basic DT for Linksys EA9500
In-Reply-To: <CACna6rzeuy+-0cQCUCrXYBnLv-twrzVvd65L6LANPPejarWAWQ@mail.gmail.com>
References: <20170223104025.5755-1-zajec5@gmail.com>
 <bd36df47-cefe-5736-e02c-621a21ae1b7a@openwrt.org>
 <CACna6rzN-OQv4UJoRso_Kyf1rCEtuU5Lu9LDjvTTt011UgrA=Q@mail.gmail.com>
 <5c57772b-71fd-d9e2-efe6-1175cf048e0b@openwrt.org>
 <CACna6rzeuy+-0cQCUCrXYBnLv-twrzVvd65L6LANPPejarWAWQ@mail.gmail.com>
Message-ID: <e756072c-f633-2507-ec58-7dfbf037f582@openwrt.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Rafal,

On 2017-02-23 13:51, Rafa? Mi?ecki wrote:
> On 23 February 2017 at 13:44, Imre Kaloz <kaloz@openwrt.org> wrote:
>> On 2017-02-23 13:29, Rafa? Mi?ecki wrote:
>>> On 23 February 2017 at 13:27, Imre Kaloz <kaloz@openwrt.org> wrote:
>>>> As discussed for other platforms as well, please use the board's name as
>>>> the
>>>> same board can end up being sold under multiple model numbers.
>>>>
>>>> So please rename the file to bcm47094-linksys-panamera.dts
>>> Huh? Where did you get panamera name from?!
>> Your manners shine on these dark days of winter. For about a decade now,
>> http://192.168.1.1/sysinfo.cgi will show you quite a bit of information if
>> you are too lazy to look into the GPL tarball or at the original bootlogs.
> Sadly Linksys doesn't sponsor me or provide me any hardware. The
> bootlogs I found:
> https://www.snbforums.com/threads/ea9500-serial-console-to-cfe.35228/
> http://www.dd-wrt.com/phpBB2/viewtopic.php?t=288470&start=30
> didn't include board name. As you probably can guess
> http://192.168.1.1/ was useful in my case as well.
>

I've guessed you have the hardware - so you're submitting dts files 
without testing it? I know they don't do much, but still, this is an 
interesting concept.

Anyways, if you are just adding support for hardware blindly, the dd-wrt 
forum you've mentioned has other posts that might help you [1].


Best,

Imre

[1] http://www.dd-wrt.com/phpBB2/viewtopic.php?p=1062050
