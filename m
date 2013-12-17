From: ckeepax@opensource.wolfsonmicro.com (Charles Keepax)
Date: Tue, 17 Dec 2013 15:14:24 +0000
Subject: [PATCH CRITICAL] ARM: s3c64xx: dt: Fix boot failure due to
 double clock initialization
In-Reply-To: <20131216210915.GD3185@sirena.org.uk>
References: <1386964779-29457-1-git-send-email-tomasz.figa@gmail.com>
 <CAOesGMifjnTDUcsweOwsw9fFgsE7b4q3wsASfP8YL-uMH5KiPA@mail.gmail.com>
 <CAPTRvHn7yTt6mC1fjEn5Ra9yx=GZ1DyNQtGWvHsDd_LkuiM_wA@mail.gmail.com>
 <1500417.9RFCmzklxv@flatron> <20131216210915.GD3185@sirena.org.uk>
Message-ID: <20131217151424.GB11138@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 16, 2013 at 09:09:15PM +0000, Mark Brown wrote:
> On Sat, Dec 14, 2013 at 04:41:06AM -0800, Tomasz Figa wrote:
> 
> >  - Wolfson Cragganmore 6410 - Mark Brown (copied) is using it for some
> >    testing of audio codec AFAIK, but I'm not sure if you can get that
> >    anywhere.
> 
> Essentially no, though you could try asking nicely.  It's not suitable
> for a test farm anyway without a SD mux as the only bootloader supported
> is Qi which only boots from flash.

Yeah, we don't have that many spare at the moment and whilst we
do use them fairly regularly we are not produce new boards
anymore.

Thanks,
Charles
