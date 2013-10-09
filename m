From: horms@verge.net.au (Simon Horman)
Date: Thu, 10 Oct 2013 08:59:20 +0900
Subject: [PATCH 1/2] ARM: shmobile: bockw: enable HPB-DMAC in defconfig
In-Reply-To: <52559ACA.4050509@cogentembedded.com>
References: <201309290011.28982.sergei.shtylyov@cogentembedded.com>
 <20130930005033.GC30501@verge.net.au>
 <52559ACA.4050509@cogentembedded.com>
Message-ID: <20131009235918.GA26091@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 09, 2013 at 08:04:58PM +0200, Sergei Shtylyov wrote:
> On 30-09-2013 2:50, Simon Horman wrote:
> 
> >>Enable HPB-DMAC driver in 'bockw_defconfig'.
> 
> >>Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> 
> >Thanks, I will queue this up for v3.13.
> 
>    As I understand you're waiting for lazy Vinod to merge the driver fixes? :-)

I am holding off on sending a pull request for these defconfig updates
until Vinod takes the fixes. Could you ping him about them?
