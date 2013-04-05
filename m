From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Fri, 05 Apr 2013 14:49:22 +0200
Subject: mmc: mxs-mmc: add non-removeable property
In-Reply-To: <CAAAP30GCRsS4JhAy0yP5su3mVm-NNTxtVS0cddxWGVwS3C6gNw@mail.gmail.com>
References: <CAAAP30HvkQNTS1+7QddAV4CZVo=g3vaJGjJNNFu3CCbGDHTqsQ@mail.gmail.com>
 <515EC00E.5060009@pengutronix.de>
 <CAAAP30GCRsS4JhAy0yP5su3mVm-NNTxtVS0cddxWGVwS3C6gNw@mail.gmail.com>
Message-ID: <515EC852.8080404@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/05/2013 02:31 PM, Alexandre Pereira da Silva wrote:
> On Fri, Apr 5, 2013 at 9:14 AM, Marc Kleine-Budde <mkl@pengutronix.de>
> wrote:
>> I'm not subscribed to linux-mmc and on
>> http://news.gmane.org/gmane.linux.kernel.mmc I just see Marek's
>> Reviewed-by. Can you point me to the discussion?
> 
> http://marc.info/?l=linux-kernel&m=136515344220293&w=2

tnx

>> If your card detect is not connected and the card is removable, you
>> should use broken-cd and base you patch on mine.
> 
> Ok, I will do that.

I've just posted an updated series.

Marc
-- 
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 263 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130405/4d5617ad/attachment.sig>
