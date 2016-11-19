From: olof@lixom.net (Olof Johansson)
Date: Fri, 18 Nov 2016 17:49:29 -0800
Subject: [GIT PULL] Second Round of Renesas ARM Based SoC DT Updates for
 v4.10
In-Reply-To: <cover.1479391750.git.horms+renesas@verge.net.au>
References: <cover.1479391750.git.horms+renesas@verge.net.au>
Message-ID: <20161119014929.GE2543@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 17, 2016 at 03:11:45PM +0100, Simon Horman wrote:
> Hi Olof, Hi Kevin, Hi Arnd,
> 
> Please consider these second round of Renesas ARM based SoC DT updates for v4.10.
> 
> This pull request is based on a merge of:
> 
> * The previous round of such requests, tagged as renesas-dt-for-v4.10,
>   which I have already sent a pull-request for.
> * The rzg-clock-defs tag of Geert Uytterhoeven's renesas-driver's tree.
>   This is to provide dependencies for adding the r8a7743 and r8a7745 SoCs.
> * The "Second Round of Renesas ARM Based SoC Drivers Updates for v4.10",
>   tagged as renesas-drivers2-for-v4.10, which I have also sent a pull
>   request for. This is included to provide dependencies for adding device
>   nodes for PRR, and adding the r8a7743 and r8a7745 SoCs..

Again, nack. And again, I don't understand why you create dependencies that
aren't needed. Please fix.


-Olof
