From: helgaas@kernel.org (Bjorn Helgaas)
Date: Tue, 27 Mar 2018 14:57:24 -0500
Subject: [PATCH v3 0/6] PCI: aardvark: misc fixes and improvements
In-Reply-To: <20180327162016.7df5c684@windsurf.home>
References: <20180327140819.23501-1-thomas.petazzoni@bootlin.com>
 <20180327162016.7df5c684@windsurf.home>
Message-ID: <20180327195723.GG7759@bhelgaas-glaptop.roam.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 27, 2018 at 04:20:16PM +0200, Thomas Petazzoni wrote:
> On Tue, 27 Mar 2018 16:08:06 +0200, Thomas Petazzoni wrote:
> 
> > This patch series brings a number of improvements to the aardvark
> > PCIe. Sorry for being so slow at sending the v3 after the v2 sent in
> > January. Hopefully this time around the series will be fine.
> 
> Sorry, I screwed up. I'm not sure how, but I did. The series was sent
> twice, and only the second iteration is correct, the first one lacked
> some Cc: to stable.
> 
> I have marked the bogus patches as Superseded in patchwork, so if you
> look at patchwork, you will only see the patches worth considering.
> 
> Let me know if you would like to resend anyway.

No worries, no need to resend for that.  And also no need to resend to
rebase them.

Lorenzo is out this week, but I'm sure he'll look at them when he
returns.  They all look pretty straightforward and obviously only
affect aardvark, so we may still be able to squeeze them in for v4.17.

Bjorn
