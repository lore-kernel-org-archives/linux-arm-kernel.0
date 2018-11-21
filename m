From: quentin.schulz@bootlin.com (Quentin Schulz)
Date: Wed, 21 Nov 2018 08:52:20 +0100
Subject: [PATCH v3 4/5] phy: mvebu-cp110-comphy: convert to use eth phy
 mode and submode
In-Reply-To: <d80901b2-a38a-7abf-23b2-c2b0c84ff321@ti.com>
References: <20181120012424.11802-1-grygorii.strashko@ti.com>
 <20181120012424.11802-5-grygorii.strashko@ti.com>
 <d80901b2-a38a-7abf-23b2-c2b0c84ff321@ti.com>
Message-ID: <20181121075220.z6smcpk3y7vab7ix@qschulz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kishon,

On Wed, Nov 21, 2018 at 01:08:42PM +0530, Kishon Vijay Abraham I wrote:
> Antoine,
> 
> On 20/11/18 6:54 AM, Grygorii Strashko wrote:
> > Convert mvebu-cp110-comphy PHY driver to use recently introduced
> > PHY_MODE_ETHERNET and phy_set_mode_ext().
> 
> Care to give ACK for this patch?
> 

Acked-by Antoine and Tested-by Maxime given in v2:
https://patchwork.kernel.org/patch/10676749/

Quentin
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181121/32cde8c4/attachment.sig>
