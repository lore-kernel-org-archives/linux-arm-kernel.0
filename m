From: david.woodhouse@intel.com (Woodhouse, David)
Date: Thu, 21 Feb 2013 16:37:59 +0000
Subject: [RFC] arm: use built-in byte swap function
In-Reply-To: <alpine.LFD.2.03.1302202327370.6419@syhkavp.arg>
References: <20130129181046.GC25415@pd.tnic>
 <1360141322.6066.4.camel@shinybook.infradead.org>
 <20130206191905.ac8eb6743e69425f30888704@freescale.com>
 <20130207181315.GM17833@n2100.arm.linux.org.uk>
 <1360344301.6066.263.camel@shinybook.infradead.org>
 <alpine.LFD.2.02.1302081503430.6300@xanadu.home>
 <1360363233.6066.283.camel@shinybook.infradead.org>
 <alpine.LFD.2.02.1302081745500.6300@xanadu.home>
 <20130208191208.2ef3d78bda71aa7b44d00d7b@freescale.com>
 <alpine.LFD.2.02.1302082102380.6300@xanadu.home>
 <20130219203115.114eab79e8d2099c6306d921@freescale.com>
 <alpine.LFD.2.03.1302192151280.6419@syhkavp.arg>
 <1361356696.13482.269.camel@i7.infradead.org>
 <alpine.LFD.2.03.1302200835380.6419@syhkavp.arg>
 <1361367842.13482.279.camel@i7.infradead.org>
 <alpine.LFD.2.03.1302200905300.6419@syhkavp.arg>
 <1361372008.13482.280.camel@i7.infradead.org>
 <alpine.LFD.2.03.1302201040460.6419@syhkavp.arg>
 <20130220214943.9b28a5b208da9f081387c55e@freescale.com>
 <alpine.LFD.2.03.1302202327370.6419@syhkavp.arg>
Message-ID: <1361464675.24822.53.camel@i7.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2013-02-20 at 23:29 -0500, Nicolas Pitre wrote:
> > > On Wed, 20 Feb 2013, Woodhouse, David wrote:
> > > > For today's compilers, unless the wind changes.
>  ? 
> Crap.  OK, assembly code is the way to go then.

How quickly the wind changes, these days. I blame global warming. :)

-- 
                   Sent with MeeGo's ActiveSync support.

David Woodhouse                            Open Source Technology Centre
David.Woodhouse at intel.com                              Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: smime.p7s
Type: application/x-pkcs7-signature
Size: 6242 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130221/e7973c0b/attachment-0001.bin>
