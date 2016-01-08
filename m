From: wsa@the-dreams.de (Wolfram Sang)
Date: Fri, 8 Jan 2016 08:45:23 +0100
Subject: [PATCH 1/2] Document: i2c: Add a dt binding for mediatek MT2701
 soc
In-Reply-To: <1452215573.2088.1.camel@mhfsdcap03>
References: <1451888138-11471-1-git-send-email-liguo.zhang@mediatek.com>
 <20160104095511.GB1524@katana> <1452215573.2088.1.camel@mhfsdcap03>
Message-ID: <20160108074523.GA1523@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 08, 2016 at 09:12:53AM +0800, liguo zhang wrote:
> On Mon, 2016-01-04 at 10:55 +0100, Wolfram Sang wrote:
> > On Mon, Jan 04, 2016 at 02:15:37PM +0800, Liguo Zhang wrote:
> > > Add a dt binding for the MT2701 soc.
> > > 
> > > Signed-off-by: Liguo Zhang <liguo.zhang@mediatek.com>
> > 
> > This should probably go with the other patch via arm-soc, or?
> 
> The patch about i2c dts info for MT2701 depends on the MT2701 clock
> patch. After the MT2701 clock patch is accepted, the i2c patch for
> MT2701 may be accepted.

OK. Still, dts changes go via arm-soc 99% of the cases if there is no
specific need to go via i2c.

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160108/d118318f/attachment.sig>
