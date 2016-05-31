From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 31 May 2016 10:59:15 +0200
Subject: [PATCH v2] clk: sunxi: predivider handling for factors clock
In-Reply-To: <20160531103905.faf5e2b80d60d46c8757ad1c@free.fr>
References: <1461084466-20889-1-git-send-email-vishnupatekar0510@gmail.com>
 <1461084466-20889-2-git-send-email-vishnupatekar0510@gmail.com>
 <20160502111337.GR17159@lukather>
 <CAEzqOZvnKKNs_sXUJrwTykA5mzwKMg+HpaFcKgBTFr+utT4qQg@mail.gmail.com>
 <20160530184532.GD4908@lukather>
 <20160531103905.faf5e2b80d60d46c8757ad1c@free.fr>
Message-ID: <20160531085915.GK4908@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 31, 2016 at 10:39:05AM +0200, Jean-Francois Moine wrote:
> On Mon, 30 May 2016 20:45:32 +0200
> Maxime Ripard <maxime.ripard@free-electrons.com> wrote:
> 
> > I went over all the A83T clocks, and most of them could be
> > covered. The issue only lies in the PLLs and their additional 1-bit
> > dividers.
> > 
> > If we just choos to ignore (one of) them, it should be pretty trivial
> > to implement with the current clock classes we have.
> 
> Hi Maxime,
> 
> I already did the job for all the A83T clocks.
> It is not fully tested yet, but, to be sure we are on the same way,
> I am sending a RFC series.

Awesome, thanks!

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160531/72963101/attachment.sig>
