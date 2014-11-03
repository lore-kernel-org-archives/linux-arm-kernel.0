From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 3 Nov 2014 13:33:11 +0100
Subject: [PATCH v4 02/58] serial: at91: Use dmaengine_slave_config API
In-Reply-To: <5457632C.5020002@atmel.com>
References: <1414531573-18807-1-git-send-email-maxime.ripard@free-electrons.com>
 <1414531573-18807-3-git-send-email-maxime.ripard@free-electrons.com>
 <5457632C.5020002@atmel.com>
Message-ID: <20141103123311.GJ11263@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Nicolas,

On Mon, Nov 03, 2014 at 12:12:44PM +0100, Nicolas Ferre wrote:
> On 28/10/2014 22:25, Maxime Ripard :
> > We are removing the dmaengine_device_control API, that shouldn't even have been
> > exposed in the first place. Change the callers to use the proper API.
> > 
> > Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> 
> Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
> 
> Thanks, Maxime. Do I have to carry the patch myself or is it part of a
> series?

I think it would be better to keep it together with that serie, since
we're removing dmaengine_device_control in a latter patch. If it's ok
for you of course.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141103/f3fef5a0/attachment-0001.sig>
