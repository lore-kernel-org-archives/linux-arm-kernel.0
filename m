From: olof@lixom.net (Olof Johansson)
Date: Sun, 18 Jun 2017 19:04:07 -0700
Subject: [GIT PULL] Reset controller changes for v4.13, part 2
In-Reply-To: <1496910681.2941.16.camel@pengutronix.de>
References: <1496910681.2941.16.camel@pengutronix.de>
Message-ID: <20170619020407.GG30022@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 08, 2017 at 10:31:21AM +0200, Philipp Zabel wrote:
> Dear arm-soc maintainers,
> 
> please consider merging this tag for v4.13. It adds a new TI SCI reset
> controller driver, adds reset offsets for Stratix10, and switches to
> kref for reference counting on the reset_control structures.
> 
> regards
> Philipp
> 
> The following changes since commit 2acb037fc42b8ce5ae59a7d5db3c9b35672e3dd7:
> 
>   reset: Add a Gemini reset controller (2017-05-24 10:46:13 +0200)
> 
> are available in the git repository at:
> 
>   git://git.pengutronix.de/git/pza/linux.git tags/reset-for-4.13-2
> 
> for you to fetch changes up to 28df169b9afa121153ef2a3ef4ceae72512cde6d:
> 
>   reset: Add the TI SCI reset driver (2017-06-06 09:44:17 +0200)
> 
> ----------------------------------------------------------------
> Reset controller changes for v4.13, part 2
> 
> - Add reset manager offsets for Stratix10
> - Use kref for reset contol reference counting
> - Add new TI SCI reset driver for TI Keystone SoCs

Merged, thanks.


-Olof
