From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 20 Mar 2014 16:15:51 +0100
Subject: [PATCH 0/4] sunxi clock fixes
In-Reply-To: <5329ECCE.7010700@elopez.com.ar>
References: <1395253173-30437-1-git-send-email-emilio@elopez.com.ar>
 <20140319190418.30995.17661@quantum>
 <5329ECCE.7010700@elopez.com.ar>
Message-ID: <20140320151551.GO27873@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Mar 19, 2014 at 04:15:26PM -0300, Emilio L?pez wrote:
> Hi Mike,
> 
> El 19/03/14 16:04, Mike Turquette escribi?:
> >Quoting Emilio L?pez (2014-03-19 11:19:29)
> >>Hi everyone,
> >>
> >>This is a small series of patches fixing a couple of bugs that are
> >>present on the sunxi clock driver. Mike, are there any chances we can
> >>take these during the 3.15 merge window or -rc period?
> >
> >I can take these towards 3.15. Do you want me to take the dts patch too?
> 
> I'd rather have Maxime take it to avoid potential conflicts. That
> patch can wait in any case; there's no actual pll4 consumer in tree
> just yet.

I sent my last pull request for the merge window, but I can queue it
up as a fix for a later 3.15-rc*

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140320/78607325/attachment-0001.sig>
