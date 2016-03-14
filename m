From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 14 Mar 2016 19:51:34 +0100
Subject: [PATCH 1/3] ARM: dts: sun8i: Fix wrong Quad core / a33 compat
 for sun8i-a23-gt90h-v4
In-Reply-To: <1457973145-26203-1-git-send-email-hdegoede@redhat.com>
References: <1457973145-26203-1-git-send-email-hdegoede@redhat.com>
Message-ID: <20160314185134.GD30977@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 14, 2016 at 05:32:23PM +0100, Hans de Goede wrote:
> As the dts file name already implies sun8i-a23-gt90h-v4.dts is for
> an a23 equipped tablet. I don't know how the "Quad Core" or a33
> comaptible got in there, likely a copy and paste error.
> 
> Regardless this commit fixes this, note this is almost
> purely a cosmetical fix, for all things that matter at the
> machine compatible level the a23 and a33 are compatible.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Applied all three, thanks

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160314/35f2da9f/attachment-0001.sig>
