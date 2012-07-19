From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri, 20 Jul 2012 07:21:12 +0900
Subject: [GIT PULL] Samsung cleanup-2 for v3.6
In-Reply-To: <201207172058.28993.arnd@arndb.de>
References: <142c01cd639c$2f081800$8d184800$%kim@samsung.com>
 <201207172058.28993.arnd@arndb.de>
Message-ID: <194e01cd65fc$ce163be0$6a42b3a0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd Bergmann wrote:
> 
> On Monday 16 July 2012, Kukjin Kim wrote:
> > Here is second Samsung cleanup pull request for v3.6.
> > Please pull from:
> >   git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git
> > next/cleanup-samsung-2
> >
> > It is related in using common GPIO API and removing unused GPIOs.
> >
> > If any problems, please let me know.
> >
> 
> Very nice series, I've merged it into next/cleanup now.
> 
Thanks.

> Two general comments on your submissions:
> 
> 1. Please put the branch name into the same line as the git url, that
> makes it slightly faster for me to copy-and-paste the pull location.
> 
Yeah, I know. If the line exceeds 80 columns (actually, 76 columns),
automatically, my e-mail client adds new line when I send git-pull or
anything else to mailing-list. And the git address which is including branch
name is included in the case :-(
So I will change the options of e-mail client when I send pull-request.

> 2. If you can, please use signed tags for your pull requests rather
> than branch names. A signed tag means that you can write the text
> for the merge changeset yourself so I don't have to do the description.
> Ideally the signing key should have signatures from other people in the
> keyring so everybody can check the authenticity of the request, but
> just having the changelog there also helps.
> 
OK, I see. I will try to use it as per your suggestion. But I'm not familiar
with that now. So if you don't mind I'd like to send signed tag from next
merge window :-)

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
