From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 21 Jan 2015 10:06:48 +0100
Subject: [PATCH v2] ARM: dts: sunxi: Add simplefb nodes for de_be0-lcd0,
 de_be0-lcd0-tve0 pipelines
In-Reply-To: <1421672712-13298-2-git-send-email-hdegoede@redhat.com>
References: <1421672712-13298-1-git-send-email-hdegoede@redhat.com>
 <1421672712-13298-2-git-send-email-hdegoede@redhat.com>
Message-ID: <20150121090648.GC4367@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 19, 2015 at 02:05:12PM +0100, Hans de Goede wrote:
> Add simplefb nodes for "[de_fe0-]de_be0-lcd0" and "[de_fe0-]de_be0-lcd0-tve0"
> display pipelines for when u-boot has set up a pipeline to drive a LCD panel /
> VGA output rather then the HDMI output.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Dropped the first version, and replaced it with this one.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150121/3eca085a/attachment-0001.sig>
