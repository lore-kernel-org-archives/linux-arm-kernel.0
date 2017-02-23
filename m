From: zajec5@gmail.com (=?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?=)
Date: Thu, 23 Feb 2017 13:51:10 +0100
Subject: [PATCH] ARM: dts: BCM5301X: Add basic DT for Linksys EA9500
In-Reply-To: <5c57772b-71fd-d9e2-efe6-1175cf048e0b@openwrt.org>
References: <20170223104025.5755-1-zajec5@gmail.com>
 <bd36df47-cefe-5736-e02c-621a21ae1b7a@openwrt.org>
 <CACna6rzN-OQv4UJoRso_Kyf1rCEtuU5Lu9LDjvTTt011UgrA=Q@mail.gmail.com>
 <5c57772b-71fd-d9e2-efe6-1175cf048e0b@openwrt.org>
Message-ID: <CACna6rzeuy+-0cQCUCrXYBnLv-twrzVvd65L6LANPPejarWAWQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 23 February 2017 at 13:44, Imre Kaloz <kaloz@openwrt.org> wrote:
> On 2017-02-23 13:29, Rafa? Mi?ecki wrote:
>>
>> On 23 February 2017 at 13:27, Imre Kaloz <kaloz@openwrt.org> wrote:
>>>
>>> As discussed for other platforms as well, please use the board's name as
>>> the
>>> same board can end up being sold under multiple model numbers.
>>>
>>> So please rename the file to bcm47094-linksys-panamera.dts
>>
>> Huh? Where did you get panamera name from?!
>
> Your manners shine on these dark days of winter. For about a decade now,
> http://192.168.1.1/sysinfo.cgi will show you quite a bit of information if
> you are too lazy to look into the GPL tarball or at the original bootlogs.

Sadly Linksys doesn't sponsor me or provide me any hardware. The
bootlogs I found:
https://www.snbforums.com/threads/ea9500-serial-console-to-cfe.35228/
http://www.dd-wrt.com/phpBB2/viewtopic.php?t=288470&start=30
didn't include board name. As you probably can guess
http://192.168.1.1/ was useful in my case as well.

-- 
Rafa?
