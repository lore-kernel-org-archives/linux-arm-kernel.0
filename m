From: horms@verge.net.au (Simon Horman)
Date: Thu, 29 Oct 2015 07:34:01 +0900
Subject: [PATCH] ARM: shmobile: henninger: remove board DT
In-Reply-To: <2890345.M5sT48V28r@wasted.cogentembedded.com>
References: <2890345.M5sT48V28r@wasted.cogentembedded.com>
Message-ID: <20151028223358.GA27318@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 29, 2015 at 12:34:29AM +0300, Sergei Shtylyov wrote:
> The Henninger low cost board was never sold and so  had  no  users outside
> Renesas (and Cogent Embedded). Instead Renesas  has made the Porter  board
> which has mostly similar hardware. Now that the Porter board support is on
> par with Henninger, we can remove  the Henninger's device tree file.
> 
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

Thanks, I have queued this up for v4.5.
