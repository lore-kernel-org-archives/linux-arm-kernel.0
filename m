From: gregkh@linuxfoundation.org (Greg KH)
Date: Fri, 7 Sep 2012 08:40:08 -0700
Subject: [PATCH] serial: omap: fix compile breakage
In-Reply-To: <1347032059-8901-1-git-send-email-balbi@ti.com>
References: <20120907153136.GA8634@kroah.com>
 <1347032059-8901-1-git-send-email-balbi@ti.com>
Message-ID: <20120907154008.GA21216@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 07, 2012 at 06:34:19PM +0300, Felipe Balbi wrote:
> when rebasing patches on top of Greg's tty-next,
> it looks like automerge broke a few things which
> I didn't catch (for whatever reason I didn't
> have OMAP Serial enabled on .config) so I ended
> up breaking the build on Greg's tty-next branch.
> 
> Fix the breakage by re-adding the three missing
> members on struct uart_omap_port.
> 
> Reported-by: Tony Lindgren <tony@atomide.com>
> Signed-off-by: Felipe Balbi <balbi@ti.com>
> ---
> 
> Hi Greg,
> 
> I just fetched your tree again and rebased again just to
> make sure. Everything is fine here, let me know if it
> still applies with fuzz.

That worked, thanks.

greg k-h
