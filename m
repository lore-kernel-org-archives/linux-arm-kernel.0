From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Fri, 07 Mar 2014 17:59:04 +0100
Subject: [PATCH V3 00/12] CCF support for Renesas r7s72100
In-Reply-To: <20140307164741.GJ28943@katana>
References: <1394208048-32495-1-git-send-email-wsa@the-dreams.de>
 <1552759.qGZNIXqrb1@avalon> <20140307164741.GJ28943@katana>
Message-ID: <1725290.WIBK8uYmkH@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 07 March 2014 17:47:41 Wolfram Sang wrote:
> > > That would have saved only 2 lines since we need the workaround anyhow
> > > (MTU2) and would break the incremental approach of this series somewhat.
> > > I'd like to keep it.
> > 
> > It would have saved one patch. If Simon needs to apply CCF support
> > separately I'm fine with that approach, but if both changes are applied
> > at the same time the SCIF patches could go in first.
> 
> Which one would be saved? We need to workaround anyhow (patch 5) and
> some scif cleanup besides the workaround is needed, too (patch 7). No?

Indeed, I got it wrong. We can leave it as-is then.

-- 
Regards,

Laurent Pinchart
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 490 bytes
Desc: This is a digitally signed message part.
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140307/78845570/attachment-0001.sig>
