From: mhowe@cwlinux.com (Morgan Howe)
Date: Tue, 15 Jun 2010 15:20:51 +0800
Subject: mxcmmc driver hangs on sync
In-Reply-To: <20100615063142.GU17833@buzzloop.caiaq.de>
References: <20100615112936.5d03ce92@morgan>
	<20100615063142.GU17833@buzzloop.caiaq.de>
Message-ID: <20100615152051.26e4589c@morgan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 15 Jun 2010 08:31:43 +0200
Daniel Mack <daniel@caiaq.de> wrote:

> Hi,
> 
> On Tue, Jun 15, 2010 at 11:29:36AM +0800, Morgan Howe wrote:
> > With the older kernel this would hang on sync after a few thousand
> > loops, and much sooner if you ran 2 or 3 of these processes at a
> > time. I tried last night with the newer kernel and kicking off 3
> > processes and after ~100-150 loops per process I get this:
> 
> Which 'newer kernel' did you try?

Hey Daniel,

Sorry, I said current mainline, but actually it's 2.6.35-rc1.

Regards,
Morgan
