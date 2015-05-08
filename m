From: balbi@ti.com (Felipe Balbi)
Date: Fri, 8 May 2015 11:36:13 -0500
Subject: [PATCH v3 3/6] usb: dwc3: dwc3-st: Update the incorrect DT dwc3
 example.
In-Reply-To: <20150508103140.GA15502@griffinp-ThinkPad-X1-Carbon-2nd>
References: <1430400652-3366-1-git-send-email-peter.griffin@linaro.org>
 <1430400652-3366-4-git-send-email-peter.griffin@linaro.org>
 <20150507151358.GA14123@griffinp-ThinkPad-X1-Carbon-2nd>
 <20150507161555.GA29183@saruman.tx.rr.com>
 <20150508103140.GA15502@griffinp-ThinkPad-X1-Carbon-2nd>
Message-ID: <20150508163613.GH16571@saruman.tx.rr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 08, 2015 at 11:31:40AM +0100, Peter Griffin wrote:
> Hi Felipe,
> 
> On Thu, 07 May 2015, Felipe Balbi wrote:
> 
> > On Thu, May 07, 2015 at 04:13:58PM +0100, Peter Griffin wrote:
> > > Hi Felipe,
> > > 
> > > On Thu, 30 Apr 2015, Peter Griffin wrote:
> > > 
> > > > There is a subtle typo phys-names should be phy-names. Using the
> > > > current example means you don't have working usb (as you fail to
> > > > obtain the phys). Also update the example to use the generic phy
> > > > type constants which are now used for miphy28.
> > > > 
> > > > Additionally also remove the unnecessary new line in the example.
> > > > 
> > > > Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
> > > > Acked-by: Rob Herring <robh@kernel.org>
> > > > Acked-by: Maxime Coquelin <maxime.coquelin@st.com>
> > > 
> > > Can you take this dwc3 DT doc update patch via your tree?
> > 
> > only this patch ?
> 
> Yes, I think the test will go via Maximes STI tree
> 
> > Sure. Just post on linux-usb and I'll fetch it from
> > there.
> 
> Brilliant, thanks. I've sent it see here https://lkml.org/lkml/2015/5/7/809
> with linux-usb on CC (sorry for missing that off the first time round)

it's in my testing/next now.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150508/d3d1021d/attachment.sig>
