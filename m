From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 19 Jun 2012 15:20:39 -0300
Subject: [PATCH, RFC] i.MX DRM support
In-Reply-To: <1339681407-28721-1-git-send-email-s.hauer@pengutronix.de>
References: <1339681407-28721-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <CAOMZO5DsM1KuxjVPdOwJjHfjV7akFs1KQkBLzarSmYykNhpBaQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 14, 2012 at 10:43 AM, Sascha Hauer <s.hauer@pengutronix.de> wrote:
> Hi All,
>
> The following is the state-of-the-art i.MX IPU (Image Processing Unit)
> DRM support.
>
> This code is around for quite some time now and has been posted several
> times with different APIs, first with plain old framebuffer support, now
> DRM, first platform device binding, now devicetree. Unfortunately there's
> quite much code needed to get something useful out of the IPU, so these
> patches haven't received a lot of attention from people not involved in
> i.MX. I think we have now come to a point where this code needs more public
> exposure and where it's easier to talk in incremental changes instead of
> blobs. Therefore I request this to go to staging for some cycles. This
> would allow us to have something in mainline as a base for further discussion
> while still being able to change bigger amounts of the driver without breaking
> officially supported features. What do you think about this?

+1 on this.

Thanks for your hard work on this, Sascha.

Regards,

Fabio Estevam
