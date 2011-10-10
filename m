From: rjw@sisk.pl (Rafael J. Wysocki)
Date: Mon, 10 Oct 2011 23:46:41 +0200
Subject: [PATCH] PM: HIBERNATION: add resume_delay kernel param as well as
	resume_delay
In-Reply-To: <20111010165437.GA11093@elf.ucw.cz>
References: <1318225452-10397-1-git-send-email-Barry.Song@csr.com>
	<20111010165437.GA11093@elf.ucw.cz>
Message-ID: <201110102346.41331.rjw@sisk.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday, October 10, 2011, Pavel Machek wrote:
> On Sun 2011-10-09 22:44:12, Barry Song wrote:
> > From: Barry Song <baohua.song@csr.com>
> > 
> > patch "PM: HIBERNATION: add resume_wait param to support MMC-like devices
> > as resume file" add resume_wait param. this patch adds resume_delay so that
> > resume_wait/delay has the same model with root_wait/delay.
> > 
> > Signed-off-by: Barry Song <baohua.song@csr.com>
> 
> ACK.

Applied to linux-pm/linux-next.

Thanks,
Rafael
