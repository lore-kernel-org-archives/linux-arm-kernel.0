From: ciminaghi@gnudd.com (Davide Ciminaghi)
Date: Wed, 28 Nov 2012 17:33:12 +0100
Subject: [PATCH 5/8] mmci: replace readsl/writesl with
 ioread32_rep/iowrite32_rep
In-Reply-To: <CACRpkdaWNC0ayN4JbEq63W+KLUdYfH5SmSu8=CNucQNixvmPUw@mail.gmail.com>
References: <1353683310-23654-1-git-send-email-ciminaghi@gnudd.com>
 <1353683310-23654-6-git-send-email-ciminaghi@gnudd.com>
 <CACRpkdaWNC0ayN4JbEq63W+KLUdYfH5SmSu8=CNucQNixvmPUw@mail.gmail.com>
Message-ID: <20121128163312.GC16612@mail.gnudd.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 28, 2012 at 05:08:27PM +0100, Linus Walleij wrote:
> On Fri, Nov 23, 2012 at 4:08 PM, Davide Ciminaghi <ciminaghi@gnudd.com> wrote:
> 
> > Not all the architectures have readsl/writesl,
> > use the more portable ioread32_rep/iowrite32_rep functions instead.
> >
> > Signed-off-by: Davide Ciminaghi <ciminaghi@gnudd.com>
> 
> Can't think of anything better, put it in Russell's patch tracker when
> you think you're finished with it.

ok, will do that.

Thanks and regards
Davide
