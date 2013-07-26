From: dwmw2@infradead.org (David Woodhouse)
Date: Fri, 26 Jul 2013 14:50:53 +0100
Subject: [Ksummit-2013-discuss] DT bindings as ABI [was: Do we have
 people interested in device tree janitoring / cleanup?]
In-Reply-To: <20130726134551.GI29916@titan.lakedaemon.net>
References: <20130725175702.GC22291@e106331-lin.cambridge.arm.com>
 <51F168FC.9070906@wwwdotorg.org>
 <20130725182920.GA24955@e106331-lin.cambridge.arm.com>
 <20130725184834.GA8296@netboy>
 <20130725213753.GC17616@obsidianresearch.com>
 <20130726080115.GA5436@netboy>
 <1374831744.2923.42.camel@shinybook.infradead.org>
 <20130726130927.GC4219@netboy>
 <20130726132709.GH29916@titan.lakedaemon.net>
 <20130726133802.GN24642@n2100.arm.linux.org.uk>
 <20130726134551.GI29916@titan.lakedaemon.net>
Message-ID: <1374846653.14574.96.camel@i7.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2013-07-26 at 09:45 -0400, Jason Cooper wrote:
> 
> We agree, I was just highlighting that attributes outside of chosen can
> and need to be rewritten by the bootloader.

Yes, absolutely. I had actually edited and re-ordered my message
<1374831744.2923.42.camel@shinybook.infradead.org> to try to make that
clearer by explicitly saying that the nodes which describe hardware
devices *can* change, before I ever made any mention of /chosen as
something which is almost *exclusively* dynamic.

Evidently that wasn't sufficient clarification. :)

-- 
dwmw2
-------------- next part --------------
A non-text attachment was scrubbed...
Name: smime.p7s
Type: application/x-pkcs7-signature
Size: 5745 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130726/93200ee8/attachment.bin>
