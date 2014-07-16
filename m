From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Wed, 16 Jul 2014 15:47:20 +0200
Subject: [GIT PULL] Mediatek basic support for v3.17
In-Reply-To: <14060966.Jhk08lR3XI@wuerfel>
References: <CABuKBe+h0Et5_+o4_i-Eu7EQ8Xka7YFoKmO=U0B7NnVQBdQ8FA@mail.gmail.com>
 <20140715135913.GA18571@kroah.com> <14060966.Jhk08lR3XI@wuerfel>
Message-ID: <CABuKBe+pF4jxSqot5KhOfzvnyK1d3PmfsMuL2HJ9jbUPFaYCOg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2014-07-15 17:17 GMT+02:00 Arnd Bergmann <arnd@arndb.de>:
> On Tuesday 15 July 2014 06:59:13 Greg KH wrote:
>> On Tue, Jul 15, 2014 at 01:11:42PM +0200, Matthias Brugger wrote:
>> > The following changes since commit 7171511eaec5bf23fb06078f59784a3a0626b38f:
>> >
>> >   Linux 3.16-rc1 (2014-06-15 17:45:28 -1000)
>> >
>> > are available in the git repository at:
>> >
>> >   https://github.com/mbgg/linux-mediatek.git tags/v3.17-next-basic-support
>>
>> As these are only 7 patches, why do a git pull?  And I know I can't take
>> pull requests from github, I'm not sure what the rules are for the ARM
>> SoC developers either...
>>
>> Just send patches, it's easier that way.
>
> We generally prefer pull requests, but patches also work for us.
>
> However, one note about the text in the pull request: Matthias,
> please always try to be explicit about who you want to pull or
> merge things when you are ready and list in the pull request the
> other maintainers that have agreed to merging it (or whether they
> have not sent an Ack yet, which is even more important).

Ok, thank you for the advice. I will do so in the next pull request.

>
> In this case, the clocksource driver needs an Ack from the clocksource
> maintainers, and the drivers/of/address.c changes need an Ack from the
> OF maintainers. I assume you have those, but I'd have to first look
> at the patches to be sure.
>
>         arnd

For the drivers/of/address.c patch I used to have an Ack [1] from
Grant Likely who told me to merge it through arm-soc. But I deleted
the Ack after changing the patch because of some comments from Russel
King [2].
So at the moment I don't have any Ack anymore.

I have an Ack for the clocksource driver from Thomas [0]. Daniel
wanted to merge it through his branch, but because of the changes in
the OF patch he never did.

So I suppose I have to get some comments from the OF maintainer about
the patch, before we can go on with the pull request.

Sorry for the noise.

Matthias

[0] http://thread.gmane.org/gmane.linux.documentation/24562/focus=24665
[1] http://thread.gmane.org/gmane.linux.documentation/24447/focus=331382
[2] https://lkml.org/lkml/2014/6/20/676


-- 
motzblog.wordpress.com
