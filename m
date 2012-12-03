From: ciminaghi@gnudd.com (Davide Ciminaghi)
Date: Mon, 3 Dec 2012 17:55:53 +0100
Subject: [PATCH 5/8] mmci: replace readsl/writesl with
 ioread32_rep/iowrite32_rep
In-Reply-To: <20121203144754.GI20074@mudshark.cambridge.arm.com>
References: <1353683310-23654-1-git-send-email-ciminaghi@gnudd.com>
 <1353683310-23654-6-git-send-email-ciminaghi@gnudd.com>
 <20121203144754.GI20074@mudshark.cambridge.arm.com>
Message-ID: <20121203165553.GA22807@mail.gnudd.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 03, 2012 at 02:47:54PM +0000, Will Deacon wrote:
> Hi Davide,
> 
> On Fri, Nov 23, 2012 at 03:08:27PM +0000, Davide Ciminaghi wrote:
> > Not all the architectures have readsl/writesl,
> > use the more portable ioread32_rep/iowrite32_rep functions instead.
> 
> I've already got a patch for this in my io branch:
> 
>   https://git.kernel.org/?p=linux/kernel/git/will/linux.git;a=shortlog;h=refs/heads/io
>
oh sorry, didn't know that.
 
> but since I've been dragging my feet on that series, you can also have my
> ack:
> 
>   Acked-by: Will Deacon <will.deacon@arm.com>
> 
ok thanks and regards
Davide
