From: balbi@ti.com (Felipe Balbi)
Date: Wed, 27 Feb 2013 10:33:23 +0200
Subject: [RESEND PATCH v9 0/2] usb: phy: samsung: Introducing usb phy
 driver for samsung SoCs
In-Reply-To: <CAFp+6iGx1z9BcE3nLTVvOMG6VWVuYhDuKm5wu3DtbL8M1pfUtg@mail.gmail.com>
References: <1358499623-13901-1-git-send-email-p.paneri@samsung.com>
 <20130227081521.GG8016@arwen.pp.htv.fi>
 <CAFp+6iGx1z9BcE3nLTVvOMG6VWVuYhDuKm5wu3DtbL8M1pfUtg@mail.gmail.com>
Message-ID: <20130227083323.GJ8016@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 27, 2013 at 02:00:25PM +0530, Vivek Gautam wrote:
> Hi Balbi,
> 
> 
> On Wed, Feb 27, 2013 at 1:45 PM, Felipe Balbi <balbi@ti.com> wrote:
> > Hi,
> >
> > On Fri, Jan 18, 2013 at 02:30:21PM +0530, Praveen Paneri wrote:
> >> Changes from v8:
> >> Resending this patch series after rebasing to the latest usb-next branch.
> >> Rewording inline comments for better readability.
> >> Removed IS_ENABLED(CONFIG_OF) as pdev->dev.of_node is enough to check for dt support.
> >> Using of_match_ptr to add of_match_table to platform_driver structure.
> >> Removed unnecessary variables.
> >
> > trying applying these but it doesn't apply unfortunately.
> >
> 
> Already present in 3.8.0 ? ;-)

heh, my bad. For whatever reason it was still marked as unread.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130227/5af5b783/attachment.sig>
