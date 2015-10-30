From: thierry.reding@gmail.com (Thierry Reding)
Date: Fri, 30 Oct 2015 18:37:38 +0100
Subject: [PATCH 09/19] drm: sun4i: Add DT bindings documentation
In-Reply-To: <CAL_JsqLuUUApGAgdw7U8EJ7p5yrYJg8AKFB32AE9Ufrf47=WpQ@mail.gmail.com>
References: <1446214865-3972-1-git-send-email-maxime.ripard@free-electrons.com>
 <1446214865-3972-10-git-send-email-maxime.ripard@free-electrons.com>
 <CAL_JsqLuUUApGAgdw7U8EJ7p5yrYJg8AKFB32AE9Ufrf47=WpQ@mail.gmail.com>
Message-ID: <20151030173738.GD17183@ulmo.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 30, 2015 at 11:40:03AM -0500, Rob Herring wrote:
> On Fri, Oct 30, 2015 at 9:20 AM, Maxime Ripard
[...]
> > +Optional properties:
> > +  - allwinner,tv-encoder: phandle to the TV Encoder in our pipeline
> > +  - allwinner,panel: phandle to the panel used in our RGB interface
> 
> Use of-graph please.

Why? Panels are a really simple resource and a simple phandle is fully
capable of describing the relationship.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151030/9fa83dce/attachment.sig>
