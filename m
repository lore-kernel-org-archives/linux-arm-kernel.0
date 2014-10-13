From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 13 Oct 2014 12:02:38 +0200
Subject: [PATCH v2 7/7] ARM: dts: sun6i: Add required ahb1 clock parent
 and rates for dma controller
In-Reply-To: <CAGb2v64TE=gzPdFJwfmJfpwWZcsdZQGONh11SawfBXZkWGFKCg@mail.gmail.com>
References: <1411807795-6575-1-git-send-email-wens@csie.org>
 <1411807795-6575-8-git-send-email-wens@csie.org>
 <20140930155533.GP4081@lukather>
 <CAGb2v64TE=gzPdFJwfmJfpwWZcsdZQGONh11SawfBXZkWGFKCg@mail.gmail.com>
Message-ID: <20141013100238.GV19438@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 09, 2014 at 11:01:02AM +0800, Chen-Yu Tsai wrote:
> Hi, Mike,
> 
> Is there a recommended way for clock providers to enforce a range
> on clock rates? Tomeu's patches seem to be for clock consumers.

We discussed that in the past with Mike, and his answer at the time
was that every driver should implement that, which I did some time
ago.

However, it was before Tomeu patches, that indeed enforce constraints
at the consumer level, but I'm pretty confident we could add some
provider-side constraints quite easily.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141013/6586ff00/attachment-0001.sig>
