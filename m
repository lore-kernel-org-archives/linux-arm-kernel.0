From: nikita@compulab.co.il (Nikita Kiryanov)
Date: Mon, 30 Nov 2015 17:33:43 +0200
Subject: [PATCH 01/14] ARM: am437x: cm-t43: dts: add basic support for
 sbc-t43
In-Reply-To: <20151125230300.GA23057@rob-hp-laptop>
References: <1448371155-17307-1-git-send-email-nikita@compulab.co.il>
 <1448371155-17307-2-git-send-email-nikita@compulab.co.il>
 <20151125230300.GA23057@rob-hp-laptop>
Message-ID: <20151130153343.GB17574@skynet>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 25, 2015 at 05:03:00PM -0600, Rob Herring wrote:
> On Tue, Nov 24, 2015 at 03:19:02PM +0200, Nikita Kiryanov wrote:
> > Add basic support for SBC-T43: a CM-T43 based single board computer.
> > CM-T43 is an AM437x based System-on-Module designed to serve as a building
> > block in embedded applications. SBC-T43 is composed of CM-T43 module on
> > top of the SB-SOM-T43 baseboard.
> > Basic support includes UART, GPIO, and I2C.
> > 
> > Signed-off-by: Nikita Kiryanov <nikita@compulab.co.il>
> > Cc: Tony Lindgren <tony@atomide.com>
> > Cc: Igor Grinberg <grinberg@compulab.co.il>
> > Cc: Dmitry Lifshitz <lifshitz@compulab.co.il>
> > Cc: Ian Campbell <ijc+devicetree@hellion.org.uk>
> 
> Some minor nits below, otherwise:
> 
> Acked-by: Rob Herring <robh@kernel.org>
>

V2 coming up.
