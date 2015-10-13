From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 13 Oct 2015 20:44:22 +0200
Subject: [PATCH] ARM: dts: sun7i: Add regulator configuration for pcDuino
 v3 Nano
In-Reply-To: <1444508121-20233-1-git-send-email-ats@offog.org>
References: <1444508121-20233-1-git-send-email-ats@offog.org>
Message-ID: <20151013184422.GP2278@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Oct 10, 2015 at 09:15:21PM +0100, Adam Sampson wrote:
> The power configuration on this board is the same as the pcDuino v3.
> This will enable frequency/voltage scaling over the standard A20
> operating points from 144 MHz to 960 MHz.
> 
> Tested using cpufreq-ljt-stress-test on two pcDuino v3 Nano boards; also
> tested successfully with voltages reduced by 0.025 V.
> 
> Signed-off-by: Adam Sampson <ats@offog.org>

Applied, thanks!
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151013/f685c95d/attachment.sig>
