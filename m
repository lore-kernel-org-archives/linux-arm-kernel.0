From: nsekhar@ti.com (Nori, Sekhar)
Date: Sun, 5 Jun 2011 16:54:32 +0530
Subject: [PATCH 2/3] davinci: dm6467/T EVM: pass reference clock rate to
	dm646x_init()
In-Reply-To: <BANLkTimBef9aRWGi1=7_BPK9pNjLY0MnGLnvd1zDzjVj-VZTiQ@mail.gmail.com>
References: <1307034677-27236-1-git-send-email-nsekhar@ti.com>
	<1307034677-27236-2-git-send-email-nsekhar@ti.com>
	<BANLkTi=oj2Okguie+fje7oDRcPNcWMdAsw@mail.gmail.com>
	<B85A65D85D7EB246BE421B3FB0FBB593024D2D2D55@dbde02.ent.ti.com>
	<BANLkTimBef9aRWGi1=7_BPK9pNjLY0MnGLnvd1zDzjVj-VZTiQ@mail.gmail.com>
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB593024D2D2F44@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 03, 2011 at 22:29:26, Olof Johansson wrote:

> Only change I would like to request in that case (sorry, not
> commenting on the patch directly here), is to mark dm646x_evm
> __initdata (or even make it a local variable in the function), so for
> multiboard kernels you won't need to keep the static struct around for
> hardware you're not running on.
> 

Fixed that and sent a new version. Thanks for the review.

Regards,
Sekhar
