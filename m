From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 11 Mar 2015 13:14:33 +0000
Subject: [PATCH] n_tty: use kmalloc() instead of vmalloc() to avoid crash
 on armada-xp
In-Reply-To: <550038C9.7010807@free-electrons.com>
References: <54FF21BE.2040506@list.ru>
 <550038C9.7010807@free-electrons.com>
Message-ID: <20150311131433.GC8656@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 11, 2015 at 01:44:57PM +0100, Gregory CLEMENT wrote:
> Hi Stas,
> 
> On 10/03/2015 17:54, Stas Sergeev wrote:
> > Hello, the patch below is needed for a successful boot on armada-xp.
> > 
> 
> I am really surprised by this patch because I used the Armada XP based
> board in a daily base and I never saw this issue.

Can you provide some details about your board - does it have 8GB of
memory, ranging from 0-0xf0000000, and 4G-8G ?

Thanks.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
