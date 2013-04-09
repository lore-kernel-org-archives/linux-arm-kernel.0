From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 9 Apr 2013 15:13:58 +0200
Subject: [GIT PULL 2/8] ARM: tegra: minor fixes
In-Reply-To: <1365181426-11547-2-git-send-email-swarren@wwwdotorg.org>
References: <1365181426-11547-1-git-send-email-swarren@wwwdotorg.org>
 <1365181426-11547-2-git-send-email-swarren@wwwdotorg.org>
Message-ID: <201304091513.58302.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 05 April 2013, Stephen Warren wrote:
> This branch contains a variety of small build and run-time fixes that
> weren't important enough for 3.9.
> 
> * Enable CPU errata WARs in secondary reset handler as a preparation
>   for multi-platform support, and a related fix.
> * Don't touch DBLGAR in reset/resume handlers, so enable the code to
>   run on A15 cores.
> * Minor build fixes.
> * A fix to the Tegra clock driver.
> * Some error-handling fixes.
> 
> This branch is based on the previous fixes-for-mmc pull request.
> 

Pulled into next/fixes-non-critical, thanks!

	Arnd
