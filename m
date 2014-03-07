From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Fri, 07 Mar 2014 17:48:52 +0100
Subject: [PATCH V3 06/12] ARM: shmobile: r7s72100: add scif nodes to dtsi
In-Reply-To: <20140307164427.GI28943@katana>
References: <1394208048-32495-1-git-send-email-wsa@the-dreams.de>
 <14375215.AZLobqST6Y@avalon> <20140307164427.GI28943@katana>
Message-ID: <1588047.pDivzA3PtA@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Wolfram,

On Friday 07 March 2014 17:44:27 Wolfram Sang wrote:
> > > > As port usages is board specific, shouldn't this be moved to the board
> > > > .dts file, with only serial0 = &scif2 ?
> > > 
> > > Nope, the intention of these aliases is to have a consistent numbering
> > > of SCIF cores, similar to platform.dev_id.
> > 
> > But do we want that ? Isn't it better from a user point of view to have
> > ttySC0 regardless of whether scif2 or scif3 is used when the board has a
> > single serial port only ?
> 
> Some prefer this, some that. The current standard pattern is what I
> implemented. I think consistency makes sense for my series. If you like to
> prefer another pattern, please start a discussion at the devicetree list.

When you say standard pattern, do you mean the practice followed by most .dts 
in mainline, or is there an actual document that recommends this pattern ?

-- 
Regards,

Laurent Pinchart
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 490 bytes
Desc: This is a digitally signed message part.
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140307/4f116a35/attachment.sig>
