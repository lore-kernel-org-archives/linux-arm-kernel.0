From: horms@verge.net.au (Simon Horman)
Date: Mon, 23 Jan 2017 10:28:03 +0100
Subject: [PATCH] ARM: shmobile: r8a7779: marzen: Fix sata device status
In-Reply-To: <8b298878-672b-74fe-5196-99f8620889ac@cogentembedded.com>
References: <1484585813-22534-1-git-send-email-geert+renesas@glider.be>
 <8b298878-672b-74fe-5196-99f8620889ac@cogentembedded.com>
Message-ID: <20170123092803.GG31651@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 18, 2017 at 08:06:02PM +0300, Sergei Shtylyov wrote:
> On 01/16/2017 07:56 PM, Geert Uytterhoeven wrote:
> 
> >Device nodes representing I/O devices should be marked disabled in the
> >SoC-specific DTS, and overridden by board-specific DTSes where needed.
> >
> >Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> 
>    Simon, I'm seeing this commit in the 'devel' branch but not seeing the
> new tag containing it... forgot to tag/push?

Hi Sergei,

sorry for not responding earlier, I have been ill.

Yes you are correct, I forgot to push.
renesas-devel-20170117-v4.10-rc4 should be there now.
