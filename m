From: wsa@the-dreams.de (Wolfram Sang)
Date: Fri, 7 Mar 2014 17:44:27 +0100
Subject: [PATCH V3 06/12] ARM: shmobile: r7s72100: add scif nodes to dtsi
In-Reply-To: <14375215.AZLobqST6Y@avalon>
References: <1394208048-32495-1-git-send-email-wsa@the-dreams.de>
 <1930280.sZNcfhZEL8@avalon> <20140307162510.GF28943@katana>
 <14375215.AZLobqST6Y@avalon>
Message-ID: <20140307164427.GI28943@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> > > As port usages is board specific, shouldn't this be moved to the board
> > > .dts file, with only serial0 = &scif2 ?
> > 
> > Nope, the intention of these aliases is to have a consistent numbering
> > of SCIF cores, similar to platform.dev_id.
> 
> But do we want that ? Isn't it better from a user point of view to have ttySC0 
> regardless of whether scif2 or scif3 is used when the board has a single 
> serial port only ?

Some prefer this, some that. The current standard pattern is what I implemented.
I think consistency makes sense for my series. If you like to prefer another
pattern, please start a discussion at the devicetree list.

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140307/2cee0f3b/attachment.sig>
