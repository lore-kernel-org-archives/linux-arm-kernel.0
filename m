From: olof@lixom.net (Olof Johansson)
Date: Fri, 3 Apr 2015 13:51:26 -0700
Subject: [GIT PULL 2/2] ARM: tegra: Device tree changes for v4.1-rc1
In-Reply-To: <1427710333-13472-2-git-send-email-thierry.reding@gmail.com>
References: <1427710333-13472-1-git-send-email-thierry.reding@gmail.com>
 <1427710333-13472-2-git-send-email-thierry.reding@gmail.com>
Message-ID: <20150403205126.GE23023@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 30, 2015 at 12:12:13PM +0200, Thierry Reding wrote:
> Hi ARM SoC maintainers,
> 
> The following changes since commit c517d838eb7d07bbe9507871fab3931deccff539:
> 
>   Linux 4.0-rc1 (2015-02-22 18:21:14 -0800)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux.git tags/tegra-for-4.1-dt
> 
> for you to fetch changes up to 03650bd2010b117c5c16a75278b0d01def8e9376:
> 
>   ARM: tegra: Add EMC timings to Nyan Blaze device tree (2015-03-30 11:43:39 +0200)
> 
> ----------------------------------------------------------------
> ARM: tegra: Device tree changes for v4.1-rc1
> 
> A bunch of changes to improve support on the Nyan Big (Acer Chromebook
> 13). These enable the trackpad and make the WiFi card work. Changes to
> the userspace-exposed name of the soundcard are required for a better
> audio experience.
> 
> Support for Nyan Blaze (HP Chromebook 14) is added. It is very similar
> to Nyan Big and therefore can enjoys many of the above improvements.
> 
> Since the EMC driver can now be used to scale the frequency at which
> external memory is clocked, corresponding EMC frequency tables are added
> for Jetson TK1 and the Nyan boards.
> 
> The Jetson TK1, Beaver and Nyan boards now also use generated pinmux
> data, which makes it easier to keep it in sync with the data provided by
> syseng.

THanks, merged. Holding off on pull request 1/2.


-Olof
