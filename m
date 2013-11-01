From: horms@verge.net.au (Simon Horman)
Date: Fri, 1 Nov 2013 15:25:16 +0900
Subject: [PATCH 1/2] ARM: shmobile: bockw: enable HPB-DMAC in defconfig
In-Reply-To: <527020EB.5090203@cogentembedded.com>
References: <201309290011.28982.sergei.shtylyov@cogentembedded.com>
 <20130930005033.GC30501@verge.net.au>
 <52559ACA.4050509@cogentembedded.com>
 <20131009235918.GA26091@verge.net.au>
 <52571745.6080307@cogentembedded.com>
 <20131011022302.GC32056@verge.net.au>
 <525864D7.8050403@cogentembedded.com>
 <527020EB.5090203@cogentembedded.com>
Message-ID: <20131101062515.GA22183@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 29, 2013 at 11:56:11PM +0300, Sergei Shtylyov wrote:
> Hello.
> 
> On 10/12/2013 12:51 AM, Sergei Shtylyov wrote:
> 
> >>>>>>>Enable HPB-DMAC driver in 'bockw_defconfig'.
> 
> >>>>>>>Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> 
> >>>>>>Thanks, I will queue this up for v3.13.
> 
> >>>>>    As I understand you're waiting for lazy Vinod to merge the driver
> >>>>>fixes? :-)
> 
> >>>>I am holding off on sending a pull request for these defconfig updates
> >>>>until Vinod takes the fixes. Could you ping him about them?
> 
> >>>    Already done yesterday.
> 
> >>Thanks
> 
> >    Vinod has taken them today.
> 
>    Simon, I still don't see these 2 defconfig patches queued and it
> seems too late for 3.13 now... :-(

Indeed it is. But they are queued as of yesterday.
