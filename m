From: sr@denx.de (Stefan Roese)
Date: Tue, 17 Jul 2012 13:47:49 +0200
Subject: [PATCH v2 0/4] Clk: SPEAr: Rename clk ids within predefined limit
In-Reply-To: <20120717103832.GK1994@localhost.localdomain>
References: <cover.1342411982.git.vipulkumar.samar@st.com>
 <201207170915.14246.arnd@arndb.de>
 <20120717103832.GK1994@localhost.localdomain>
Message-ID: <201207171347.49721.sr@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shiraz,

On Tuesday 17 July 2012 12:38:32 Shiraz Hashim wrote:
> On Tue, Jul 17, 2012 at 09:15:13AM +0000, Arnd Bergmann wrote:
> > What's the plan for these patches? Are you (either of you) sending a pull
> > request for v3.6 or are they actually required for v3.5 as well?
> 
> Yes they are required (together with other acked fixes) for v3.5,
> else SPEAr support won't be functional. I hope it is not too late.
> 
> We can prepare fixes branch and send across a pull request.

Could you please also push this patch for 3.5:

http://www.spinics.net/lists/arm-kernel/msg174614.html

Without it, SPEAr600 won't boot as I already mentioned a few times.

Thanks,
Stefan
