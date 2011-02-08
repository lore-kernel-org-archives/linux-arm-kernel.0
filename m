From: paul@pwsan.com (Paul Walmsley)
Date: Mon, 7 Feb 2011 18:45:31 -0700 (MST)
Subject: [PATCH v2 3/9] omap4: powerdomain: Use intended PWRSTS_* flags
	instead of values
In-Reply-To: <1296813544-25170-4-git-send-email-santosh.shilimkar@ti.com>
References: <1296813544-25170-1-git-send-email-santosh.shilimkar@ti.com>
	<1296813544-25170-4-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <alpine.DEB.2.00.1102071845140.21991@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 4 Feb 2011, Santosh Shilimkar wrote:

> IVAHD and ABE power domain logic state is populated using directly
> value instead of the capability flags.
> 
> Fix the same.
> 
> This was getting generated due to a bug 'gen_logicst' macro
> in powerdomain autogen script bug which is fixed as well.

Should we try to get this one into the -rc series, since it is a bug-fix ?

- Paul
