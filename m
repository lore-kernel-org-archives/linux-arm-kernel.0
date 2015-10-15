From: horms@verge.net.au (Simon Horman)
Date: Thu, 15 Oct 2015 09:18:18 +0900
Subject: [PATCH] ARM: shmobile: porter: add HS-USB DT support
In-Reply-To: <80272771.MSjafmr6yE@wasted.cogentembedded.com>
References: <1674850.BZpGW9kEud@wasted.cogentembedded.com>
 <80272771.MSjafmr6yE@wasted.cogentembedded.com>
Message-ID: <20151015001818.GA25019@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 14, 2015 at 10:35:46PM +0300, Sergei Shtylyov wrote:
> Enable HS-USB device  for the Porter board, defining the GPIO that the
> driver should check  when probing (which is the ID output from MAX3355
> OTG chip).
> 
> Note that there  will be pinctrl-related error messages if both internal
> PCI  and  HS-USB drivers are enabled but they should be just ignored.
> 
> This patch is  analogous  to the commit 6f4f7156e0e6 (ARM: shmobile:
> henninger: enable HS-USB) as there  are no differences between the
> boards in this respect.
> 
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> 

Thanks Sergei,

I have queued this up for v4.5.

I took the liberty of tweaking the changelog to address a complaint made
by Mr. Check Patch.

ERROR: Please use git commit description style 'commit <12+ chars of sha1> ("<title line>")' - ie: 'commit 6f4f7156e0e6 ("ARM: shmobile: henninger: enable HS-USB")'
