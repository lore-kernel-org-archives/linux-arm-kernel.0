From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 25 May 2012 16:20:10 +0800
Subject: [PATCH 1/1] dma: imx-sdma: buf_tail should be initialize in
 prepare function
In-Reply-To: <20120525080943.GA18733@b20223-02.ap.freescale.net>
References: <1337603494-27464-1-git-send-email-richard.zhao@freescale.com>
 <20120524032026.GB17621@S2101-09.ap.freescale.net>
 <20120524032659.GA19682@b20223-02.ap.freescale.net>
 <20120524033356.GC17621@S2101-09.ap.freescale.net>
 <20120525080943.GA18733@b20223-02.ap.freescale.net>
Message-ID: <20120525082008.GH3332@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 25, 2012 at 04:09:44PM +0800, Richard Zhao wrote:
> On Thu, May 24, 2012 at 11:33:58AM +0800, Shawn Guo wrote:
> > On Thu, May 24, 2012 at 11:27:00AM +0800, Richard Zhao wrote:
> > > > root at linaro-developer:~# aplay audio8k16S.wav
> > > > Playing WAVE 'audio8k16S.wav' : Signed 16 bit Little Endian, Rate 8000 Hz, Stere
> > > > o
> > > > ^Z
> > > > [1]+  Stopped                 aplay audio8k16S.wav
> > > > root at linaro-developer:~# fg
> > > > aplay audio8k16S.wav
> > > > underrun!!! (at least 2034.382 ms long)
> > > Does the audio playback recover? Without the patch, sometimes the
> > > playback will have distortion and play too fast.
> > > 
> > No, it does not recover.
> Maybe it's not the same issue. It do recover on imx6q sabrelite board.
> And from source code, it do be a bug.
> 
It seems to be the case, so:

Acked-by: Shawn Guo <shawn.guo@linaro.org>

-- 
Regards,
Shawn
