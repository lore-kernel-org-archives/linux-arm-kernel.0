From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Tue, 02 Nov 2010 13:27:18 +0000
Subject: [PATCH v2 2/4] OMAP3: PM: update DSP reset code to use new SCM
	DSP boot control functions
In-Reply-To: <1288109763-9446-3-git-send-email-omar.ramirez@ti.com> (Omar
	Ramirez Luna's message of "Tue, 26 Oct 2010 11:16:01 -0500")
References: <1288109763-9446-1-git-send-email-omar.ramirez@ti.com>
	<1288109763-9446-3-git-send-email-omar.ramirez@ti.com>
Message-ID: <874obzg8jt.fsf@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Omar Ramirez Luna <omar.ramirez@ti.com> writes:

> From: Paul Walmsley <paul@pwsan.com>
>
> Update the DSP reset code in pm34xx.c to use one of the new SCM DSP
> boot control functions, omap2430_ctrl_set_dsp_bootmode().
>
> This reset code should be moved out to a separate function to be
> called by the hwmod reset process at some point.  Also, 2430
> should be initializing the DSP in a similar fashion.
>
> Signed-off-by: Paul Walmsley <paul@pwsan.com>
> Cc: Kevin Hilman <khilman@deeprootsystems.com>

Acked-by: Kevin Hilman <khilman@deeprootsystems.com>

In PATCH 0/x, please report on what platforms this was tested.

Kevin
