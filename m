From: paul@pwsan.com (Paul Walmsley)
Date: Wed, 13 Jun 2012 11:22:12 -0600 (MDT)
Subject: [PATCHv2 04/12] ARM: OMAP4: hwmod data: fix 32k sync timer idle
 modes
In-Reply-To: <4FD5BAE7.7080805@ti.com>
References: <20120611004502.20034.8840.stgit@dusk>
 <20120611004602.20034.73590.stgit@dusk> <4FD5BAE7.7080805@ti.com>
Message-ID: <alpine.DEB.2.00.1206131121580.30212@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 11 Jun 2012, Cousson, Benoit wrote:

> On 6/11/2012 2:46 AM, Paul Walmsley wrote:
> > The 32k sync timer IP block target idle modes are incorrect in the
> > hwmod data are incorrect.
> 
> Nit: Is there too many "incorrect" in this sentence?

Thanks; patch updated.


- Paul
