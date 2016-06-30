From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 30 Jun 2016 22:41:52 +0200
Subject: [linux-sunxi] Re: [PATCH 06/14] ARM: dts: sun8i: Add cpu0 label
 to sun8i-h3.dtsi
In-Reply-To: <CAOMqctTocMFztGh7N0y=06XYGKGzx_qknM8v1VdJSuV8L7OdBQ@mail.gmail.com>
References: <20160623192104.18720-1-megous@megous.com>
 <20160623192104.18720-7-megous@megous.com>
 <CAGb2v66eskVAxdz8VtjBJBCO7VV9WL4bdFDVrPWrSmxk4RASCw@mail.gmail.com>
 <adaf7f61-af80-cc02-8c47-af721b86f81e@megous.com>
 <CAGb2v665O75vQEfo5WdWtWJSbKEbLi6MBAHbgZC7pyrOCOu+6g@mail.gmail.com>
 <20160625070208.GA4000@lukather>
 <380ebf34-fd4a-ea2d-f9cf-68b8ede44757@megous.com>
 <20160629204553.GJ6095@lukather>
 <a3cf3531-93a5-de35-b7f4-03d28cfebb3d@megous.com>
 <CAOMqctTocMFztGh7N0y=06XYGKGzx_qknM8v1VdJSuV8L7OdBQ@mail.gmail.com>
Message-ID: <20160630204152.GD5485@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 30, 2016 at 01:04:40PM +0200, Michal Suchanek wrote:
> > You're probably right. Operating points should be part of h3.dtsi, and
> > if some board is particularly bad, and can't handle being above certain
> > frequency safely, due to thermal design issues, we can override
> > operating points in its dts file.
> >
> 
> Can you override them?
> 
> AFAIK you cannot replace a property set in SoC file in a board file.

You totally can, we have litterally dozens of examples of that already.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160630/bd9715b7/attachment-0001.sig>
