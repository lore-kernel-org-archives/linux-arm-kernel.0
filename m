From: f.fainelli@gmail.com (Florian Fainelli)
Date: Tue, 16 Sep 2014 12:09:23 -0700
Subject: [GIT PULL 3.18] ARM: BCM: Broadcom BCM63138 support
In-Reply-To: <201409161827.24548.arnd@arndb.de>
References: <1409953475-23130-1-git-send-email-f.fainelli@gmail.com>
 <54167614.7030806@gmail.com>
 <CAEPRUYrcpaUmLvr4k5GK11wRbQ8XwFQdxRJPeunH7p-w7jL2-Q@mail.gmail.com>
 <201409161827.24548.arnd@arndb.de>
Message-ID: <54188AE3.60500@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/16/2014 09:27 AM, Arnd Bergmann wrote:
> On Monday 15 September 2014, Christian Daudt wrote:
>>>
>>>
>>> Arnd has reviewed v2, and v3 addresses his former comments, he has not
>>> replied with an Ack though I do not mind waiting for this.
>>
>> Ok - explicit is better than implicit. Arnd - can you pls confirm your
>> ack to these patches ?
> 
> I'm glad you asked, because it triggered me to look at the pull request.
> The patches are all good, feel free to add
> 
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> 
> to each patch, or to the merge, whichever works for you.
> 
> However, the pull request was done wrong, so don't merge this changeset
> into your branch or we won't pull it from you.
> 
> The problem is that it is based on top of out for-next branch, which is
> not meant to be sent upstream to Linus. Instead as you know we expect
> all pull requests coming in from platform maintainers to be done as
> topic branches and normall based on top of the previous -rc1 release,
> or possibly a later -rcX release if you have a strong dependency on 
> a bug fix that went into that release.
> 
> I'd recommend that Florian rebases from 244a68e90d0775d3e579 to
> v3.17-rc1 and send a new pull request, but it's also fine if you
> do the rebase and add your Signed-off-by to the patches in the process.

I will do this and create a tag for Christian to pull from. Thanks!
--
Florian
