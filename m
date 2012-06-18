From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 18 Jun 2012 17:50:49 -0300
Subject: [PATCH v4 2/2] serial: mxs-auart: Allow device tree probing
In-Reply-To: <4FDF929B.7000809@grid-net.com>
References: <1339774557-23588-1-git-send-email-fabio.estevam@freescale.com>
 <1340024769-7122-1-git-send-email-fabio.estevam@freescale.com>
 <4FDF929B.7000809@grid-net.com>
Message-ID: <CAOMZO5CHJGCE0fwh=u65gO7P8c8hT9Yd5+3__rFtmNMLstTwEQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 18, 2012 at 5:42 PM, Subodh Nijsure <snijsure@grid-net.com> wrote:
>
> If one were to try run console on one of the /dev/ttyAPP* ports, as is the
> case for hardware I am working with, console output wouldn't show up without
> the following diff:
>
> Let me know if should send formal patch or we can include it as part of v5?

Please send a formal patch. Shawn has already applied my patch into his tree:
http://git.linaro.org/gitweb?p=people/shawnguo/linux-2.6.git;a=shortlog;h=refs/heads/mxs/for-next
