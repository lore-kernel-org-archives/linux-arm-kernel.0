From: dinguyen@opensource.altera.com (Dinh Nguyen)
Date: Tue, 7 Oct 2014 10:51:18 -0500
Subject: socfpga ethernet problems with ethernet in 3.17 with
 u-boot-2013.01.01
In-Reply-To: <20141007121017.GA20998@amd>
References: <20141007121017.GA20998@amd>
Message-ID: <54340BF6.4030602@opensource.altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/07/2014 07:10 AM, Pavel Machek wrote:
> Hi!
> 
> After some testing:
> 
> u-boot-2013.01.01 + linux-3.17 => ethernet does	not work
>                   (unless ethernet is used in u-boot, for example
>                   using ping)
> u-boot-marex-20140920a + linux-3.17 => working ethernet
> 
> One of our guesses is that maybe we don't pull ethernet out of reset
> in the first case?
> 

v3.17 has the reset driver framework that the stmmac driver uses to
deassert the reset.

Dinh
