From: tony@atomide.com (Tony Lindgren)
Date: Thu, 3 Dec 2015 08:13:56 -0800
Subject: [PATCH V2 12/14] ARM: dts: sb-som: introduce SB-SOM baseboard
In-Reply-To: <20151203142408.GA24844@rob-hp-laptop>
References: <1448978109-5614-1-git-send-email-nikita@compulab.co.il>
 <1448978109-5614-13-git-send-email-nikita@compulab.co.il>
 <20151203142408.GA24844@rob-hp-laptop>
Message-ID: <20151203161356.GN23396@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Rob Herring <robh@kernel.org> [151203 06:25]:
> On Tue, Dec 01, 2015 at 03:55:07PM +0200, Nikita Kiryanov wrote:
> > CompuLab SB-SOM baseboard is a carrier board for multiple arm-based SoMs.
> > It currently supports (with minor adjustments to assembly) CM-T43, CM-T54,
> > and CM-QS600 modules. It is a building block in the SBC-T43 single board
> > computer, which consists of cm-t43 on top of sb-som-t43.
> > 
> > Signed-off-by: Nikita Kiryanov <nikita@compulab.co.il>
> > Cc: Tony Lindgren <tony@atomide.com>
> > Cc: Benoit Cousson <bcousson@baylibre.com>
> > Cc: Rob Herring <robh@kernel.org>
> > Cc: Mark Rutland <mark.rutland@arm.com>
> > Cc: Pawel Moll <pawel.moll@arm.com>
> > Cc: Igor Grinberg <grinberg@compulab.co.il>
> > Cc: Dmitry Lifshitz <lifshitz@compulab.co.il>
> > Cc: Ian Campbell <ijc+devicetree@hellion.org.uk>
> 
> Acked-by: Rob Herring <robh@kernel.org>

Applying this whole series into omap-for-v4.5/dt thanks.

Tony
