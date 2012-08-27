From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Mon, 27 Aug 2012 15:51:42 -0700
Subject: [PATCH 0/2] tty: serial: imx: fix lockup and garbage on SMP
In-Reply-To: <20120827223134.GD2281@r65073-Latitude-D630>
References: <1346053012-25686-1-git-send-email-dirk.behme@de.bosch.com>
 <20120827223134.GD2281@r65073-Latitude-D630>
Message-ID: <20120827225142.GA11302@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 28, 2012 at 06:31:35AM +0800, Shawn Guo wrote:
> On Mon, Aug 27, 2012 at 09:36:50AM +0200, Dirk Behme wrote:
> > Both issues are gone applying these two patches.
> > 
> > Note: If these patches are fine, they should go to stable, too.
> > 
> Then you should have Cc: <stable@vger.kernel.org> tag on these patches.

On both of them?  I can do that if needed.  How far back should they go?

greg k-h
