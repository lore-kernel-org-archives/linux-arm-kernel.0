From: buserror@gmail.com (M P)
Date: Mon, 21 Dec 2009 13:26:34 +0000
Subject: kernel boot failure on with s32440/mini2440 with git head
	(dd59f6c76b2)
In-Reply-To: <200912211410.12014.jbe@pengutronix.de>
References: <4B2E4A65.8070207@walsimou.com>
	<200912211410.12014.jbe@pengutronix.de>
Message-ID: <dc447790912210526l3247b8fdxfc3f7c4c99706b04@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 21, 2009 at 1:10 PM, Juergen Beisert <jbe@pengutronix.de> wrote:
> On Sonntag, 20. Dezember 2009, Gaye Abdoulaye Walsimou wrote:
>> Hello list,
>> I have here a boot Oops (see below) with the latest git revision of
>> git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git,
>> which does not happen with 2.6.32.
>> Thanks in advance for comments.
>> Regards

I have a patch in my git that related to that :
http://repo.or.cz/w/linux-2.6/mini2440.git/commit/db47bd31f00a06370795a9d94ed973f78060841a

I need to push that to the list as soon as I rebase on 2.6.33.

Michael
