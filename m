From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 27 Sep 2013 20:05:05 +0300
Subject: [PATCH 0/5] Allwinner SoCs High Speed Timer support
In-Reply-To: <20130926163942.675266e5@skate>
References: <1380117790-19390-1-git-send-email-maxime.ripard@free-electrons.com>
 <87zjr04vnh.fsf@linaro.org>
 <CAOesGMhTZS1MdHW9cL4s_X8jUXHS3VkNZupCfX4ZGroL6k4gEw@mail.gmail.com>
 <20130925195012.GI2954@lukather> <20130926163942.675266e5@skate>
Message-ID: <20130927170505.GX2954@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas,

On Thu, Sep 26, 2013 at 04:39:42PM +0200, Thomas Petazzoni wrote:
> On Wed, 25 Sep 2013 22:50:12 +0300, Maxime Ripard wrote:
> 
> > For all we know, so far, allwinner has released, by family:
> >   - sun3i (ARM926)
> >     * F20 (not supported)
> >   - sun4i (Cortex A8)
> >     * A10
> >   - sun5i (Cortex A8)
> >     * A10s
> >     * A13
> >   - sun6i (4 * Cortex A7)
> >     * A31
> >     * A31s (not supported)
> >   - sun7i (2 * Cortex A7)
> >     * A20
> >     * A23? (that was just announced)
> 
> A small update to Documentation/arm/sunxi/README would be nice :)

Yep, right. Even though, for most of these SoCs (F20, A10s, A31*, A2*),
I don't think we have publicly available datasheet to point to there.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130927/1e578ac8/attachment.sig>
