From: jekhor@gmail.com (Yauhen Kharuzhy)
Date: Fri, 3 Dec 2010 13:36:58 +0200
Subject: [PATCH] ARM S3C24XX: Fix compilation of PM code for S3C2416
In-Reply-To: <1291036180-8274-1-git-send-email-jekhor@gmail.com>
References: <1291036180-8274-1-git-send-email-jekhor@gmail.com>
Message-ID: <20101203113658.GA22365@jeknote.loshitsa1.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 29, 2010 at 03:09:40PM +0200, Yauhen Kharuzhy wrote:
> S3C2416 PM code uses low-level sleep routines from S3C2412 code,
> but these routines are compiled only for S3C2412 SoC.
> 
> Split S3C2412_PM to two parts: S3C2412_PM, S3C2412_PM_SLEEP and
> select last in S3C2416's Kconfig.
> 
> Signed-off-by: Yauhen Kharuzhy <jekhor@gmail.com>

ping?

-- 
Yauhen Kharuzhy		jekhor _at_ gmail.com
			JID: jek at jabber.ru

A: No
Q: Should I quote below my post?
