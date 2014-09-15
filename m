From: f.fainelli@gmail.com (Florian Fainelli)
Date: Sun, 14 Sep 2014 22:16:04 -0700
Subject: [GIT PULL 3.18] ARM: BCM: Broadcom BCM63138 support
In-Reply-To: <CAEPRUYpS=yqR8SvUb34eSMfOPMM4HErf4jKZK_Z9jbWvBH9vEg@mail.gmail.com>
References: <1409953475-23130-1-git-send-email-f.fainelli@gmail.com>	<8641708.a9SSBxeRCZ@wuerfel>
 <CAEPRUYpS=yqR8SvUb34eSMfOPMM4HErf4jKZK_Z9jbWvBH9vEg@mail.gmail.com>
Message-ID: <54167614.7030806@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/14/14 21:56, Christian Daudt wrote:
> On Sat, Sep 6, 2014 at 7:33 AM, Arnd Bergmann <arnd@arndb.de> wrote:
>> On Friday 05 September 2014 14:44:35 Florian Fainelli wrote:
>>> Arnd, Olof,
>>>
>>> This pull request contains the basic Broadcom BCM63138 DSL SoC support
>>> that has been posted a few weeks ago. Arnd has reviewed those changes, and
>>> I was expecting Matt to carry these changes for me, but I did not get an
>>> answer so far and I don't want these patches to be held much longer.
>>
> Hi Florian,
>   Apologies for the untimeliness of replies, I've been leaning heavily
> on Matt to lead mach-bcm maintainership but given recent changes at
> Broadcom he's found himself pressed for time to do this also.

Based on our earlier conversations on IRC this week, I was expecting you 
to send an update to the MAINTAINERS file reflecting the fact that we 
(Brian, Gregory, Marc and myself) should be listed as mach-bcm 
maintainers as well.

>   I'm looking at this patchset to pull it, but I don't see any acks on
> the patches (the git commits in your repo do not have them, and
> searching through linux-arm-kernel doesn't seem to indicate
> acks/sign-offs for them). Have they been reviewed ? If not, I'll have
> to review them prior to pulling.

Arnd has reviewed v2, and v3 addresses his former comments, he has not 
replied with an Ack though I do not mind waiting for this.

Thank you
--
Florian
