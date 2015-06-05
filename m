From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 05 Jun 2015 13:41:15 -0600
Subject: [PATCH v7 2/3] ARM: bcm2835: Add the Raspberry Pi firmware driver
In-Reply-To: <20150605192135.GA3301@x1>
References: <1433448707-18104-1-git-send-email-eric@anholt.net>
 <1433448707-18104-2-git-send-email-eric@anholt.net>
 <55711428.4080506@wwwdotorg.org> <20150605192135.GA3301@x1>
Message-ID: <5571FB5B.2030805@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/05/2015 01:21 PM, Lee Jones wrote:
> On Thu, 04 Jun 2015, Stephen Warren wrote:
>
>> On 06/04/2015 02:11 PM, Eric Anholt wrote:
>>> This gives us a function for making mailbox property channel requests
>>> of the firmware, which is most notable in that it will let us get and
>>> set clock rates.
>>
>> Acked-by: Stephen Warren <swarren@wwwdotorg.org>
>
> Does anyone know how drivers/firmware/ is managed?  I don't seem to be
> able to find a maintainer/supporter listed in MAINTAINERS.

git log implies lots of different committers. I'd suggest send it 
through arm-soc with the rest of the series.
