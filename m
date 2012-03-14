From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Wed, 14 Mar 2012 21:46:37 +0100
Subject: [PATCH v4 03/10] pwm: Add device tree support
In-Reply-To: <20120314201138.GU3852@pengutronix.de>
References: <1331740593-10807-1-git-send-email-thierry.reding@avionic-design.de>
 <1331740593-10807-4-git-send-email-thierry.reding@avionic-design.de>
 <20120314201138.GU3852@pengutronix.de>
Message-ID: <20120314204637.GA12334@avionic-0098.mockup.avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Sascha Hauer wrote:
> On Wed, Mar 14, 2012 at 04:56:26PM +0100, Thierry Reding wrote:
> > +static inline struct pwm_device *of_pwm_request(struct device_node *np,
> > +						const char *propname,
> > +						int index);
>                                                          ^^^
> 
> No semicolon here please.

Ugh. I've been doing extra compile tests to make sure the series stays
bisectible, but I guess I need to add further tests with !PWM and !OF
configurations.

Thanks,
Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120314/cbeae2b2/attachment.sig>
