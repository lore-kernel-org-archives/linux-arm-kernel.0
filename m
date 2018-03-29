From: andy.gross@linaro.org (Andy Gross)
Date: Thu, 29 Mar 2018 09:37:15 -0500
Subject: [PATCH v3 04/13] ARM: dts: ipq4019: Update ipq4019-dk01.1 board
 data
In-Reply-To: <20180320143131.4eenixtbhciq5fwc@localhost>
References: <1521518336-5467-1-git-send-email-sricharan@codeaurora.org>
 <1521518336-5467-5-git-send-email-sricharan@codeaurora.org>
 <20180320143131.4eenixtbhciq5fwc@localhost>
Message-ID: <20180329143715.GA31757@hector.attlocal.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 20, 2018 at 07:31:31AM -0700, Richard Cochran wrote:
> On Tue, Mar 20, 2018 at 09:28:47AM +0530, Sricharan R wrote:
> > Reviewed-by: Abhishek Sahu <absahu@codeaurora.org>
> > Adds missing memory, reserved-memory nodes.
> > 
> > Signed-off-by: Sricharan R <sricharan@codeaurora.org>
> > ---
> >  arch/arm/boot/dts/qcom-ipq4019-ap.dk01.1.dtsi | 28 +++++++++++++++++++++++++++
> 
> Q: Does mainline Linux even boot on the DK?
> 
> A: No, it doesn't.

If you aren't actually testing/validating this specific board, how can you make
a statement like this?  Unless you have tested these specifically on this board,
I'd appreciate not getting false information about what is or is not working.

> 
> Please add the missing basic board support before hacking random stuff
> into the DTS.

Feel free to send your own contributions where you are adding the things that
are important to you.

Regards,

Andy Gross
