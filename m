From: horms@verge.net.au (Simon Horman)
Date: Thu, 13 Mar 2014 09:09:09 +0900
Subject: [PATCH v3 07/20] ARM: shmobile: marzen: Reference clocks
In-Reply-To: <530E06E3.9070901@cogentembedded.com>
References: <1393400016-23433-1-git-send-email-horms+renesas@verge.net.au>
 <1393400016-23433-8-git-send-email-horms+renesas@verge.net.au>
 <530E06E3.9070901@cogentembedded.com>
Message-ID: <20140313000909.GH25813@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 26, 2014 at 06:23:15PM +0300, Sergei Shtylyov wrote:
> Hello.
> 
> On 02/26/2014 10:33 AM, Simon Horman wrote:
> 
> >Reference clocks using a "clocks" property in all nodes corresponding to
> >devices that require a clock: that is, the lan0 node.
> 
>    Simon, "lan0" (should be "ethernet" BTW) is the SMC chip, it
> can't use Ether clock.

Thanks, I will drop this patch.
