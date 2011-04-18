From: vitalywool@gmail.com (Vitaly Wool)
Date: Mon, 18 Apr 2011 08:23:37 +0200
Subject: [RFC 0/4] convert stmp into mxs and delete the obsolete platform
In-Reply-To: <1303093838-23959-1-git-send-email-w.sang@pengutronix.de>
References: <1303093838-23959-1-git-send-email-w.sang@pengutronix.de>
Message-ID: <BANLkTikybn1pwiz-SrgdSwV6aRcKHMAENg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Wolfram,

On Mon, Apr 18, 2011 at 4:30 AM, Wolfram Sang <w.sang@pengutronix.de> wrote:
> I tried a smaller scaled cleanup before, but now that there are talks about ARM
> consolidation everywhere, I'll be more brave :)
>
> What we have here is consolidation of two platforms. The older one, plat-stmp,
> has never seen much love after the initial commit and has poor design as stated
> in the patch descriptions. The recently added mach-mxs can be used for a
> (friendly) takeover. Adding 130 lines there could save 9500+ lines in arch/arm!

may we FIRST see how you are going to fit it into mach-mxc? NAK from
me before I see that.

BTW, I understand that you are taking steps in the right direction but
having worked with stmp3xxx and multiple i.MXs, I see it as a great
pity that a low-end but stable and convenient platform has been
effectively killed by a semiconductor giant to avoid competition with
unstable and painful to work with lower end i.MXs, and is also being
killed virtually -- by you guys.

Thanks,
   Vitaly
