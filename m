From: vz@mleia.com (Vladimir Zapolskiy)
Date: Fri, 29 Apr 2016 02:10:32 +0300
Subject: [PATCH 0/3] MAINTAINERS: add new maintainers of NXP LPC32xx SoC
In-Reply-To: <4622738.ujCxg0gb7N@wuerfel>
References: <1461714919-25577-1-git-send-email-vz@mleia.com>
 <4622738.ujCxg0gb7N@wuerfel>
Message-ID: <57229868.30403@mleia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On 27.04.2016 12:39, Arnd Bergmann wrote:
> On Wednesday 27 April 2016 02:55:16 Vladimir Zapolskiy wrote:
>> Roland Stigge added initial support of NXP LPC32xx SoC series and
>> first boards powered by it, but for a while since v3.18-rc1 the
>> SoC support is unmaintained and became stale.
>>
>> Vladimir Zapolskiy and Sylvain Lemieux expressed interest in
>> continuation of NXP LPC32xx maintenance, reflect this in MAINTAINERS
>> record file for better communication with Linux kernel community.
>>
>> The maintenance change is in agreement with Arnd Bergmann:
>>
> 
> Looks good. Let's give Roland some time to reply (hopefully with
> and Ack), and then merge it for 4.7.
> 

to simplify the matter and to legitimate the process somehow I decided
not to include this change of maintainers into my last LPC32xx SoC pull
request, hence the pull request contains only code changes.

In other words please let me explicitly delegate a decision to you or
other ARM maintainers when and which way to apply this change. As for
me here I would prefer to get Signed-off-by tags from one of you.

If I'm worried for nothing, or if you don't consider to pick these
changes up directly from linux-arm-kernel at lists.infradead.org, for
your convenience I'll send a pull request to arm at kernel.org.

For what it's worth this is a link to the last discussion with Roland
on LAKML (the discussed problems are handled at the moment):
http://lists.infradead.org/pipermail/linux-arm-kernel/2015-April/337078.html

--
With best wishes,
Vladimir
