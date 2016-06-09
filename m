From: broonie@kernel.org (Mark Brown)
Date: Thu, 9 Jun 2016 16:57:46 +0100
Subject: [RFC v4 01/14] regulator: of: Add helper for getting all supplies
In-Reply-To: <CAJZ5v0hiyyOhU7AjOEjFHjTKhT+pqWZheUG77c6u2HV9dNQ0Gg@mail.gmail.com>
References: <1465465471-28740-1-git-send-email-k.kozlowski@samsung.com>
 <1465465471-28740-2-git-send-email-k.kozlowski@samsung.com>
 <20160609102925.GS7510@sirena.org.uk>
 <CAJZ5v0hiyyOhU7AjOEjFHjTKhT+pqWZheUG77c6u2HV9dNQ0Gg@mail.gmail.com>
Message-ID: <20160609155746.GZ7510@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 09, 2016 at 02:50:26PM +0200, Rafael J. Wysocki wrote:
> On Thu, Jun 9, 2016 at 12:29 PM, Mark Brown <broonie@kernel.org> wrote:

> > The external interface shouldn't be DT specific, the Intel people are
> > busy importing all of DT into ACPI

> Well, not really.

> If you are referring to the pinctrl proposal discussed recently, that
> was a proposal from one group at Intel and AFAICS it has been
> abandoned.

Well, it was that, it was the device properties stuff in general and the
overlays stuff - plus just the fact that with the Minnowboard style use
case people have and the desire to use ACPI it seems like that's going
to be something you need.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160609/f52b40ff/attachment.sig>
