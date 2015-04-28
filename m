From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 28 Apr 2015 16:59:10 +0100
Subject: [PATCH] ARM: mvebu: dove: Relicense the device tree under
 GPLv2+/X11
In-Reply-To: <1430125744-3550-1-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1430125744-3550-1-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <20150428155910.GD12732@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 27, 2015 at 11:09:04AM +0200, Sebastian Hesselbarth wrote:
> The current implicit GPL only licensing on the device tree makes it
> very impractical for other software components licensed under another
> license.
> 
> In order to make it easier for them to reuse our device trees,
> relicense our device trees under a GPL/X11 dual-license.
> 
> Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> ---
> Hi,
> 
> with Dove we only have a small set of people who can be git blame'd for
> the DT files:
> - Jason Cooper
> - Ezequiel Garcia
> - Andrew Lunn
> - Jean-Francois Moine
> - Russell King
> - Myself
> 
> so I decided to keep the whole relicensing in a single patch. Please send
> your Acked-by's in reply to this patch if you are happy with the relicensing.

I normally don't include the "or later version" for my license changes
as I've only accepted to contribute under the terms of GPLv2.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
