From: f.fainelli@gmail.com (Florian Fainelli)
Date: Sat, 06 Sep 2014 10:55:13 -0700
Subject: [GIT PULL 3.18] ARM: BCM: Broadcom BCM63138 support
In-Reply-To: <8641708.a9SSBxeRCZ@wuerfel>
References: <1409953475-23130-1-git-send-email-f.fainelli@gmail.com>
 <8641708.a9SSBxeRCZ@wuerfel>
Message-ID: <540B4A81.6080403@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/06/14 07:33, Arnd Bergmann wrote:
> On Friday 05 September 2014 14:44:35 Florian Fainelli wrote:
>> Arnd, Olof,
>>
>> This pull request contains the basic Broadcom BCM63138 DSL SoC support
>> that has been posted a few weeks ago. Arnd has reviewed those changes, and
>> I was expecting Matt to carry these changes for me, but I did not get an
>> answer so far and I don't want these patches to be held much longer.
>
> You still need to take him on Cc at least. It's bad if Matt doesn't reply
> to your emails, but that's no excuse to send a pull request without giving
> him a chance to Ack or Nack it.
>
> Did you try contacting him on IRC? According to my logs, he was on #armlinux
> at the time you sent the pull request, although he's marked as idle now.

I have, but did not get an answer so far.

>
> Let's give Matt and Christian a few more days to reply, we can take the
> pull request if there is no reaction.

Works for me. We might want to come up with a different strategy for 
handling mach-bcm stuff in the future, the BCM_MOBILE code will most 
likely not be the highest activity.

Thanks
--
Florian
