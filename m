From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Wed, 14 Mar 2012 21:57:34 +0100
Subject: [PATCH v4 01/10] PWM: add pwm framework support
In-Reply-To: <4F610517.7090006@metafoo.de>
References: <1331740593-10807-1-git-send-email-thierry.reding@avionic-design.de>
 <1331740593-10807-2-git-send-email-thierry.reding@avionic-design.de>
 <4F610517.7090006@metafoo.de>
Message-ID: <20120314205734.GA16020@avionic-0098.mockup.avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Lars-Peter Clausen wrote:
> On 03/14/2012 04:56 PM, Thierry Reding wrote:
> > [...]
> > +struct pwm_chip {
> > +	int			pwm_id;
> > +	const char		*label;
> > +	struct pwm_ops		*ops;
> 
> Nothing major, but if you are going for another round it would be good to see
> ops made const.

I'll go for another round because I just noticed that I still have two open
TODO items that I forgot to fix from last round's review.

I'll take a note to make it const.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120314/5fdebc1d/attachment.sig>
