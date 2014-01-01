From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 2 Jan 2014 00:10:39 +0100
Subject: [PATCH v3 3/5] ARM: dts: sun7i: external clock outputs
In-Reply-To: <1388543450-16741-4-git-send-email-wens@csie.org>
References: <1388543450-16741-1-git-send-email-wens@csie.org>
 <1388543450-16741-4-git-send-email-wens@csie.org>
Message-ID: <20140101231039.GG3144@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Jan 01, 2014 at 10:30:48AM +0800, Chen-Yu Tsai wrote:
> This commit adds the two external clock outputs available on A20 to
> its device tree. A dummy fixed factor clock is also added to serve as
> the first input of the clock outputs, which according to AW's A20 user
> manual, is the 24MHz oscillator divided by 750.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

I'm ok with this patch, but I'll let Emilio and Mike give their
opinion on the driver before merging it.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140102/7db4f8c6/attachment.sig>
