From: will.deacon@arm.com (Will Deacon)
Date: Mon, 3 Feb 2014 16:44:59 +0000
Subject: [PATCH v2 08/11] of: Increase MAX_PHANDLE_ARGS
In-Reply-To: <CAL_Jsq+=dm4kPk=e0h_up9=wvED4fd3MBtSNFxm2NEz_yag-uA@mail.gmail.com>
References: <1389876263-25759-1-git-send-email-andreas.herrmann@calxeda.com>
 <1389876263-25759-9-git-send-email-andreas.herrmann@calxeda.com>
 <20140117110830.GW3471@alberich> <52E92842.3000001@amd.com>
 <CAL_JsqLhzp5jUJPA91rNkQ07kCDYCDZLxw8LxxFEVP9b12e1Jw@mail.gmail.com>
 <52E93360.1000904@amd.com> <20140129171611.GB13543@alberich>
 <52E939CB.1020705@amd.com> <20140130174546.GF13543@alberich>
 <CAL_Jsq+=dm4kPk=e0h_up9=wvED4fd3MBtSNFxm2NEz_yag-uA@mail.gmail.com>
Message-ID: <20140203164459.GL14112@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 31, 2014 at 04:24:09PM +0000, Rob Herring wrote:
> On Thu, Jan 30, 2014 at 11:45 AM, Andreas Herrmann
> <andreas.herrmann@calxeda.com> wrote:
> > Do you agree on increasing MAX_PHANDLE_ARGS to 32?
> 
> Yes, but more than that will require a closer look. Please get this
> into next early in the cycle.

If you want to get this patch in early, I suggest taking it via a tree other
than mine. I don't put my iommu queue into -next, since it goes to Joerg
around -rc4, who then sticks it in after that.

Will
