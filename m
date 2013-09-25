From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 25 Sep 2013 22:50:12 +0300
Subject: [PATCH 0/5] Allwinner SoCs High Speed Timer support
In-Reply-To: <CAOesGMhTZS1MdHW9cL4s_X8jUXHS3VkNZupCfX4ZGroL6k4gEw@mail.gmail.com>
References: <1380117790-19390-1-git-send-email-maxime.ripard@free-electrons.com>
 <87zjr04vnh.fsf@linaro.org>
 <CAOesGMhTZS1MdHW9cL4s_X8jUXHS3VkNZupCfX4ZGroL6k4gEw@mail.gmail.com>
Message-ID: <20130925195012.GI2954@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 25, 2013 at 11:14:46AM -0700, Olof Johansson wrote:
> On Wed, Sep 25, 2013 at 11:13 AM, Kevin Hilman <khilman@linaro.org> wrote:
> 
> >> However, the A20 and A31 come with 4 of these high speed timers, while the A10s
> >> and A13 only have two, hence why we introduce two different compatibles.
> >
> > ...but the A10 has 2?
> >
> > -ECONFUSED
> 
> A10s != A10. Yes, confusing. :)

Yeah, I didn't get to chose the names :)

For all we know, so far, allwinner has released, by family:
  - sun3i (ARM926)
    * F20 (not supported)
  - sun4i (Cortex A8)
    * A10
  - sun5i (Cortex A8)
    * A10s
    * A13
  - sun6i (4 * Cortex A7)
    * A31
    * A31s (not supported)
  - sun7i (2 * Cortex A7)
    * A20
    * A23? (that was just announced)

So yes, even though they are quite close, A10 != A10s :)

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130925/8a82d630/attachment.sig>
