From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Mon, 27 Apr 2015 10:33:01 -0300
Subject: [PATCH] ARM: mvebu: dove: Relicense the device tree under
 GPLv2+/X11
In-Reply-To: <1430125744-3550-1-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1430125744-3550-1-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <553E3A8D.5010602@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/27/2015 06:09 AM, Sebastian Hesselbarth wrote:
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
> 

Acked-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
-- 
Ezequiel Garc?a, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
