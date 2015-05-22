From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 22 May 2015 15:39:34 +0100
Subject: [PATCH] input: ambakmi: Fix system PM by converting to modern
 callbacks
In-Reply-To: <CAPDyKFrhC1MCmOfoweztNtzk-Spwhj1uj7-sz3UtJhT_bHDQ+g@mail.gmail.com>
References: <1429008108-29295-1-git-send-email-ulf.hansson@linaro.org>
 <CAPDyKFrhC1MCmOfoweztNtzk-Spwhj1uj7-sz3UtJhT_bHDQ+g@mail.gmail.com>
Message-ID: <20150522143933.GI2067@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 22, 2015 at 04:37:12PM +0200, Ulf Hansson wrote:
> On 14 April 2015 at 12:41, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > The legacy system PM support has long time ago been dropped from the
> > AMBA bus. Align to that by converting to the modern system PM
> > callbacks.
> >
> > Fixes: 26825cfd90f9 (ARM: 7914/1: amba: Drop legacy PM support ...)
> > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> 
> What happened with this one? Can we queue it for 4.2?

Why does it have a Fixes: tag?  Is it fixing a real bug, or is it just
fixing a warning that the kernel prints?

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
