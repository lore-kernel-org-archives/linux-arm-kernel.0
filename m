From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 30 Mar 2015 15:12:58 -0700
Subject: [PATCH 0/3] ARM: sun8i: Add SMP and arch-timer support for A23
In-Reply-To: <1426649042-30547-1-git-send-email-wens@csie.org>
References: <1426649042-30547-1-git-send-email-wens@csie.org>
Message-ID: <20150330221258.GA21316@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 18, 2015 at 11:23:59AM +0800, Chen-Yu Tsai wrote:
> Hi Maxime,
> 
> This series adds support for SMP and arch-timer for the
> A23. This follows our discussion from yesterday about
> getting arch-timer support for sun8i and sun9i. I will
> post a separate patch for sun9i-a80.
> 
> I know some people would like to see arch-timer and SMP
> supported with PSCI, but work on this has been slow. So
> in the mean time, I thought I'd just post what SMP code
> I have.
> 
> Feel free to just merge the first patch if you think SMP
> can wait.

Merged 2 and 3, thanks!

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
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150330/72d901da/attachment-0001.sig>
