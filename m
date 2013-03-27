From: pali.rohar@gmail.com (Pali =?utf-8?q?Roh=C3=A1r?=)
Date: Wed, 27 Mar 2013 22:05:16 +0100
Subject: [PATCH] arm: omap: RX-51: ARM errata 430973 workaround
In-Reply-To: <20130327205606.GN10155@atomide.com>
References: <517283541.62064.1362124023621.JavaMail.apache@mail81.abv.bg>
 <201303241526.59275@pali> <20130327205606.GN10155@atomide.com>
Message-ID: <201303272205.17182@pali>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 27 March 2013 21:56:07 Tony Lindgren wrote:
> * Pali Roh?r <pali.rohar@gmail.com> [130324 07:31]:
> > it is possible to upstream errata 430973 workaround for
> > RX-51?
> 
> I think we should make the SMC handling a generic function for
> ARM.
> 
> AFAIK just the SMC call numbering is different for various
> implementations. So the handler and passing of the parameters
> seems like it should be generic.
> 

Not only, look at freemangordon's email: 
https://lkml.org/lkml/2013/3/1/62

> Regards,
> 
> Tony

-- 
Pali Roh?r
pali.rohar at gmail.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: This is a digitally signed message part.
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130327/cf6e553e/attachment-0001.sig>
