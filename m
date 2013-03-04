From: balbi@ti.com (Felipe Balbi)
Date: Mon, 4 Mar 2013 22:19:50 +0200
Subject: [PATCH 1/2] arm: omap2: mux: fix debugfs file permission
In-Reply-To: <20130304191830.GV11806@atomide.com>
References: <1361269464-20263-1-git-send-email-balbi@ti.com>
 <20130304191830.GV11806@atomide.com>
Message-ID: <20130304201950.GA18315@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 04, 2013 at 11:18:31AM -0800, Tony Lindgren wrote:
> * Felipe Balbi <balbi@ti.com> [130219 02:28]:
> > OMAP's debugfs interface creates one file
> > for each signal in the mux table, such file
> > provides a read method but didn't provide
> > read permission. Fix it.
> > 
> > Signed-off-by: Felipe Balbi <balbi@ti.com>
> 
> Heh indeed, although read still seems to work without it.
> Applying into omap-for-v3.9/fixes.

root can always read, I guess.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130304/4b75fd5b/attachment-0001.sig>
