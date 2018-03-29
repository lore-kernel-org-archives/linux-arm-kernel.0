From: chen.zhong@mediatek.com (Chen Zhong)
Date: Thu, 29 Mar 2018 10:31:15 +0800
Subject: [PATCH v6 0/6] Add MediaTek PMIC keys support
In-Reply-To: <20180328102640.yx6nv5abfexmouuf@dell>
References: <1508937364-30054-1-git-send-email-chen.zhong@mediatek.com>
 <808b2029da224ab687fb0553cbc1c68e@mtkmbs08n1.mediatek.inc>
 <1521685073.28226.10.camel@mtkswgap22> <20180323185418.GD255819@dtor-ws>
 <20180327080507.pgil6pw2mn4y2f4d@dell>
 <3ece050c-7573-ef4e-2c89-61645a243a33@gmail.com>
 <20180328102640.yx6nv5abfexmouuf@dell>
Message-ID: <1522290675.17084.8.camel@mhfsdcap03>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2018-03-28 at 11:26 +0100, Lee Jones wrote:
> On Tue, 27 Mar 2018, Matthias Brugger wrote:
> 
> > 
> > 
> > On 03/27/2018 10:05 AM, Lee Jones wrote:
> > > On Fri, 23 Mar 2018, Dmitry Torokhov wrote:
> > >> On Thu, Mar 22, 2018 at 10:17:53AM +0800, Sean Wang wrote:
> > >>> Hi, Dmitry and Lee
> > >>>
> > >>> The series seems not being got merged. Are they good enough to be ready
> > >>> into the your tree?
> > >>>
> > >>> Recently I've tested the series with focusing on pwrkey event generated
> > >>> through interrupt when push and release the key on bpi-r2 board and then
> > >>> finally it's working fine. but for homekey it cannot be found on the
> > >>> board and thus I cannot have more tests more about it.
> > >>>
> > >>> Tested-by: Sean Wang <sean.wang@mediatek.com>
> > >>
> > >> You have my Ack on the input patch; I expect it go through Lee's tree as
> > >> there are some dependencies on mfd core piece.
> > > 
> > > Are you happy for me to merge the Input dt-bindings without your Ack?
> > > 
> > 
> > They got both Acked in v5, but the commit message was not updated:
> > https://patchwork.kernel.org/patch/9973721/
> > https://patchwork.kernel.org/patch/9973723/
> 
> Thanks Matthias.
> 
> Chen, can you collect all the Acks and repost as a RESEND please?
> 

Thanks Matthias, Lee, Dmitry and Sean for your comments.

Hi Lee,

I have collected the Acks by Rob and sent the v6:
https://patchwork.kernel.org/patch/10026705
https://patchwork.kernel.org/patch/10026707

Are they enough to be merged?

Thank you.
