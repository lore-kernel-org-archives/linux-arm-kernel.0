From: tony@atomide.com (Tony Lindgren)
Date: Fri, 6 Mar 2015 08:56:41 -0800
Subject: [PATCH v2] ARM: dts: am335x-bone-common: enable aes and sham
In-Reply-To: <CAOCHtYisxjpQM4zvotNxhj3KaYrqb3cgCbTXPXphB1ZV2jCZ8w@mail.gmail.com>
References: <1424890361-31848-1-git-send-email-mporter@konsulko.com>
 <CAOCHtYisxjpQM4zvotNxhj3KaYrqb3cgCbTXPXphB1ZV2jCZ8w@mail.gmail.com>
Message-ID: <20150306165641.GQ13520@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Robert Nelson <robertcnelson@gmail.com> [150225 11:13]:
> On Wed, Feb 25, 2015 at 12:52 PM, Matt Porter <mporter@konsulko.com> wrote:
> > Beaglebone Black doesn't have AES and SHAM enabled like the
> > original Beaglebone White dts. This breaks applications that
> > leverage the crypto blocks so fix this by enabling these nodes
> > in the am335x-bone-common.dtsi. With this change, enabling the
> > nodes in am335x-bone.dts is no longer required so remove them.
> >
> > Signed-off-by: Matt Porter <mporter@konsulko.com>
> 
> Looks good! Wonder why didn't we do this sooner! ;)
> 
> Acked-by: Robert Nelson <robertcnelson@gmail.com>

Applying both into omap-for-v4.0/fixes thanks.

Tony
