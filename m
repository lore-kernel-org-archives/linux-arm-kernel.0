From: sre@kernel.org (Sebastian Reichel)
Date: Fri, 10 Jun 2016 03:37:28 +0200
Subject: [PATCH v2 1/4] power: axp20x_usb: Add support for usb
 power-supply on axp22x pmics
In-Reply-To: <953cdbf8-fa75-cc61-edd3-1fe31545ab6d@redhat.com>
References: <1464887936-17020-1-git-send-email-hdegoede@redhat.com>
 <20160604140154.GB31801@earth>
 <953cdbf8-fa75-cc61-edd3-1fe31545ab6d@redhat.com>
Message-ID: <20160610013728.GB5848@earth>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Sat, Jun 04, 2016 at 04:09:53PM +0200, Hans de Goede wrote:
> On 04-06-16 16:01, Sebastian Reichel wrote:
> > On Thu, Jun 02, 2016 at 07:18:53PM +0200, Hans de Goede wrote:
> > > The usb power-supply on the axp22x pmics is mostly identical to the
> > > one on the axp20x pmics. One significant difference is that it cannot
> > > measure / monitor the usb voltage / current.
> > 
> > Acked-By: Sebastian Reichel <sre@kernel.org>
> > 
> > What's the merge strategy for this patchset?
> 
> All of the separate bits can be merged separately without
> problems, [...]

OK, I queued the first patch with Rob's Acked-By.

-- Sebastian
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160610/59bd4b85/attachment.sig>
