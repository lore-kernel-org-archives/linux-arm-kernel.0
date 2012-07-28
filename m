From: shawn.guo@linaro.org (Shawn Guo)
Date: Sat, 28 Jul 2012 16:25:48 +0800
Subject: [alsa-devel] [PATCH 4/4] ARM: mx28evk: add missed clkmux select
 for saif
In-Reply-To: <20120723023632.GA9427@shlinux2.ap.freescale.net>
References: <1342776027-31758-1-git-send-email-b29396@freescale.com>
 <1342776027-31758-5-git-send-email-b29396@freescale.com>
 <20120721074002.GC923@S2101-09.ap.freescale.net>
 <20120723023632.GA9427@shlinux2.ap.freescale.net>
Message-ID: <20120728082543.GB2128@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 23, 2012 at 10:36:33AM +0800, Dong Aisheng wrote:
> This patch series was made based on Mark's sound-2.6 tree.
> Do you want this one go through mxs tree and other three go through Mark's tree?

Yes.  That's the way to save conflict.

> I'm thinking maybe it would be better go through one tree(Mark's or Yours) since
> without this one the saif record still can not work.

The recording has been broken.  There is no point to force the whole
series to go via one tree.  When sound and arm-soc get merged on
linux-next (for testing) and mainline, the recording gets back to work.

-- 
Regards,
Shawn
