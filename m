From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Tue, 8 Apr 2014 10:34:12 -0600
Subject: Armada XP (mvebu) PCIe memory (BAR/window) re-allocation
In-Reply-To: <CAFJTrDuN+WPg57scaxTMkdCf--Xc96DEwXQup4pSyQV9kpD+Sw@mail.gmail.com>
References: <20140326180634.4ac266b2@skate>
 <20140326171828.GA31887@obsidianresearch.com>
 <CAFJTrDvb7gcLkv8-HqbJSLEj7V2Zg=5+pXFR2r3AZxG7waT6WA@mail.gmail.com>
 <20140401164110.GA26093@obsidianresearch.com>
 <CAFJTrDu1=Hoa6NS3DaFphMUXgJYunybbdCoGiBVe1qKNQ4s3MA@mail.gmail.com>
 <20140403182322.GA9509@obsidianresearch.com>
 <20140403202455.599d1c6b@skate>
 <CAFJTrDuQv87t4N1pbw_mCZ=pZ82pX6cab+PmuhO1Fvvax==xdg@mail.gmail.com>
 <20140407164536.GA9952@obsidianresearch.com>
 <CAFJTrDuN+WPg57scaxTMkdCf--Xc96DEwXQup4pSyQV9kpD+Sw@mail.gmail.com>
Message-ID: <20140408163412.GA27776@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 08, 2014 at 11:57:59AM +0100, Matthew Minter wrote:

> I have already posted this on the other thread, however I can confirm
> the first suggestion fixes this. It seems I am having the same issue
> regarding the power of two memory windows. Is it still helpful for me
> to do any more checks or should we consider this closed?

I think the mbus problem explains everything? Please try to find time
to test Thomas's final fix when he posts it, but others I think it can
be considered done :)

Regards,
Jason
