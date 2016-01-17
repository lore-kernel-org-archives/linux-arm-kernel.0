From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sun, 17 Jan 2016 20:59:04 +0100
Subject: [PATCH] ARM: sunxi: Add CPU regulator for cpufreq
In-Reply-To: <CAGb2v67a7DATu-sesVPE9Aypn_n0-K++TjdpXmxRSMZRiyHJ7A@mail.gmail.com>
References: <1452607153-8698-1-git-send-email-maxime.ripard@free-electrons.com>
 <CAGb2v67a7DATu-sesVPE9Aypn_n0-K++TjdpXmxRSMZRiyHJ7A@mail.gmail.com>
Message-ID: <20160117195904.GM4581@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Jan 12, 2016 at 10:17:31PM +0800, Chen-Yu Tsai wrote:
> On Tue, Jan 12, 2016 at 9:59 PM, Maxime Ripard
> <maxime.ripard@free-electrons.com> wrote:
> > The current DT doesn't have a phandle to the CPU regulator in the CPU node,
> > which disables the CPU voltage scaling entirely.
> 
> Commit message doesn't say which chip (family).

Even worse, which board :)

I've fixed it and applied it.

Thanks!
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160117/babc3cc3/attachment-0001.sig>
