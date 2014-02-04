From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 4 Feb 2014 09:45:21 +0100
Subject: [PATCH 1/2] clocksource: sunxi: Add new compatibles
In-Reply-To: <52EFF96A.1020302@linaro.org>
References: <1391348280-9484-1-git-send-email-maxime.ripard@free-electrons.com>
 <52EFC573.2050302@linaro.org> <20140203194505.GF25625@lukather>
 <52EFF96A.1020302@linaro.org>
Message-ID: <20140204084521.GH25625@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Feb 03, 2014 at 09:17:46PM +0100, Daniel Lezcano wrote:
> On 02/03/2014 08:45 PM, Maxime Ripard wrote:
> >Hi Daniel,
> >
> >(Adding DT mailing-list in CC)
> >
> >On Mon, Feb 03, 2014 at 05:36:03PM +0100, Daniel Lezcano wrote:
> >>On 02/02/2014 02:37 PM, Maxime Ripard wrote:
> >>>The Allwinner A10 compatibles were following a slightly different compatible
> >>>patterns than the rest of the SoCs for historical reasons. Add compatibles
> >>>matching the other pattern to the timer driver for consistency, and keep the
> >>>older one for backward compatibility.
> >>
> >>Hi Maxime,
> >>
> >>is it really needed to keep the old pattern ?
> >
> >We agreed during the ARM Kernel Summit to consider the DT as a stable
> >ABI.
> >
> >While I'd be ok with removing the older ones, that also means that we
> >would break the boot of newer kernels with older DT, so yes, we
> >actually need to keep the old compatibles.
> 
> Thanks for the clarification.
> 
> So these old compatibles will stay there 'ad vitam aeternam', right ?

Except for what Rob told, yep, that was my feeling, but Gregory and I
seem to have a different interpretation of this rule :)

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140204/418b5e4f/attachment-0001.sig>
