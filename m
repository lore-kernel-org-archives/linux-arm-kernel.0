From: soren.brinkmann@xilinx.com (=?utf-8?B?U8O2cmVu?= Brinkmann)
Date: Sun, 11 Jan 2015 15:01:47 -0800
Subject: [PATCH v4 0/7] pinctrl support for Zynq
In-Reply-To: <CACRpkdYLHOHhSYSJZcggmATnMRg_7Pq8-fF3c2MJW9E69DiqJg@mail.gmail.com>
References: <1420818231-13451-1-git-send-email-soren.brinkmann@xilinx.com>
 <b987f31220ab424285e27200bb187158@BY2FFO11FD012.protection.gbl>
 <CACRpkdYLHOHhSYSJZcggmATnMRg_7Pq8-fF3c2MJW9E69DiqJg@mail.gmail.com>
Message-ID: <8b127d21cad948daafffcc449cd92e4b@BL2FFO11FD014.protection.gbl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 2015-01-11 at 10:41PM +0100, Linus Walleij wrote:
> On Fri, Jan 9, 2015 at 5:53 PM, S?ren Brinkmann
> <soren.brinkmann@xilinx.com> wrote:
> > On Fri, 2015-01-09 at 07:43AM -0800, Soren Brinkmann wrote:
> >> Hi Linus,
> >>
> >> I rebased my branch onto your current pinctrl/devel. Other than that
> >> this should be exactly what has been sent out as v3. This time I'll use
> >> the gmail SMTP again, which hopefully resolves the encoding issue.
> >
> > The transfer-encoding is again 'quoted-printable'. So, seems it is not
> > exchange to blame. I tried to git am a patch from this series and it
> > seems to work fine. I.e. send-email and am apparently to the right
> > thing.
> 
> Yeah it works like a charm :)
> 
> All patches that affect the pin control tree are applied now. It is
> looking *beautiful* especially your device trees look exactly as I
> want them to look for a group/function type pin controller driver.

Thanks a lot! This is great.

@Michal: Could you please pick up the patches that go through the armsoc
tree (5 and 6 in this series)?

	Thanks,
	S?ren
