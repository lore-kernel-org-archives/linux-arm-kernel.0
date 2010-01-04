From: ben@simtec.co.uk (Ben Dooks)
Date: Tue, 05 Jan 2010 01:31:35 +0900
Subject: kernel boot failure on with s32440/mini2440 with git
	head	(dd59f6c76b2)
In-Reply-To: <4B37A6D4.9000301@walsimou.com>
References: <4B2E4A65.8070207@walsimou.com>	<200912211410.12014.jbe@pengutronix.de>	<dc447790912210526l3247b8fdxfc3f7c4c99706b04@mail.gmail.com>
	<4B37A6D4.9000301@walsimou.com>
Message-ID: <4B4217E7.5000207@simtec.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Gaye Abdoulaye Walsimou wrote:
> M P wrote:
>> On Mon, Dec 21, 2009 at 1:10 PM, Juergen Beisert <jbe@pengutronix.de> wrote:
>>   
>>> On Sonntag, 20. Dezember 2009, Gaye Abdoulaye Walsimou wrote:
>>>     
>>>> Hello list,
>>>> I have here a boot Oops (see below) with the latest git revision of
>>>> git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git,
>>>> which does not happen with 2.6.32.
>>>> Thanks in advance for comments.
>>>> Regards
>>>>       
>> I have a patch in my git that related to that :
>> http://repo.or.cz/w/linux-2.6/mini2440.git/commit/db47bd31f00a06370795a9d94ed973f78060841a
>>
>> I need to push that to the list as soon as I rebase on 2.6.33.
>>
>> Michael
>>   
> 
> Dear all,
> It is this[1] commit which breaks mini2440 board, reverting its changes
> in mini2440 code make things working again.
> By the way Michel, as you're mini2440 maintainer, why there is no pull
> requests for changes in your repository [2]
> (for example
> http://repo.or.cz/w/linux-2.6/mini2440.git/commit/db47bd31f00a06370795a9d94ed973f78060841a)
> ?
> 
> Best reagrads,
> AWG
> 
> [1]  ARM: S3C: Add NAND device platform data set call:
> http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=2a3a18045b136487b22733d57410e6dccd34ac84
> [2] http://repo.or.cz/w/linux-2.6/mini2440.git

fix already sent for this. see for-linus/samsung tree on git.fluff.org
