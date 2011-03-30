From: arnaud.patard@rtp-net.org (Arnaud Patard (Rtp))
Date: Wed, 30 Mar 2011 09:52:53 +0200
Subject: [PATCH v2 1/1] ARM: imx: add gpu device
In-Reply-To: <20110330073651.GR7285@pengutronix.de> (Sascha Hauer's message of
	"Wed, 30 Mar 2011 09:36:51 +0200")
References: <1301465128-401-1-git-send-email-richard.zhao@freescale.com>
	<20110330073651.GR7285@pengutronix.de>
Message-ID: <87aagdrqne.fsf@lebrac.rtp-net.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sascha Hauer <s.hauer@pengutronix.de> writes:

Hi,

> On Wed, Mar 30, 2011 at 02:05:28PM +0800, Richard Zhao wrote:
>> From: Richard Zhao <richard.zhao@linaro.org>
>> 
>> Add mxc_gpu devices for imx35/50/51/53, so external gpu driver module built
>> for the kernel can work.
>
> Why do we need this? I have never seen a driver for this.
>
