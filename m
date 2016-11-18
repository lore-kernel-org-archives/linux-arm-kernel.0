From: olof@lixom.net (Olof Johansson)
Date: Thu, 17 Nov 2016 23:17:58 -0800
Subject: [GIT PULL] pxa for v4.10
In-Reply-To: <87a8d9wr6d.fsf@belgarion.home>
References: <87a8d9wr6d.fsf@belgarion.home>
Message-ID: <20161118071758.GA1785@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 08, 2016 at 11:19:22PM +0100, Robert Jarzmik wrote:
> Hello Arnd, Kevin, Olof,
> 
> Please consider this pull request for pxa 4.10 cycle. This pull request strides
> off from my usual ones as its spans more than just mach-pxa.
> 
> The following changes since commit 1001354ca34179f3db924eb66672442a173147dc:
> 
>   Linux 4.9-rc1 (2016-10-15 12:17:50 -0700)
> 
> are available in the git repository at:
> 
>   https://github.com/rjarzmik/linux.git tags/pxa-for-4.10
> 
> for you to fetch changes up to e413bd33ac44b6d0bebc0ef2ac19cbe7558a7303:
> 
>   ARM: pxa: fix pxa25x interrupt init (2016-11-05 21:48:18 +0100)
> 
> ----------------------------------------------------------------
> This is the pxa changes for v4.10 cycle.
> 
> This cycle is covering :
>  - some clock fixes common with sa1100 architecture
>  - the consequence of the pxa_camera conversion to v4l2
>  - a small irq related fix for pxa25x device-tree only

Thanks, merged.


-Olof
