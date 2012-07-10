From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 10 Jul 2012 14:01:29 +0000
Subject: [PATCH v9] arm: Add basic support for new Marvell Armada 370 and
 Armada XP SoC
In-Reply-To: <4FFC1DA5.6050805@free-electrons.com>
References: <1341588221-3822-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <201207101203.30984.arnd@arndb.de> <4FFC1DA5.6050805@free-electrons.com>
Message-ID: <201207101401.30607.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 10 July 2012, Gregory CLEMENT wrote:
> We have a public git tree available at:
> 
> https://github.com/Marvell-Semi/EBU_mainline_public.git
> 
> this last patch set is directly from mvebu_for-next-V9 branch.
> 
> Do you need a formal request?

I've pulled it now, but I would generally prefer if you use
"git request-pull" to generate the pull request, and use a signed
tag as the reference so you can include the series description
in the tag.

I had to rebase the series because the version in your tree was based on
an outdated for-next branch. You really can't send me stuff based on 
the for-next branch because that does not have a stable history.
Please instead make everything based on whatever is the newest -rc
release at the time you start the series. Also please take a look
at how other people like Tony Lindgren or Stephen Warren do larger
sets of pull requests.

	Arnd
